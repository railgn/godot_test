class_name ActionsMenu
extends Node2D

signal intent_chosen(intent: Intent)

var chosen_intent:= Intent.new()

var unit: BattlePlayerUnit

var unit_stations: Node
var mirror_cast_resource
var dialogue_box: Node

var control_index_memory: Dictionary

static func new_actions_menu(init_unit: BattlePlayerUnit, init_unit_stations, init_dialogue_box, init_control_index_memory) -> ActionsMenu:
	var actions_menu_scene: PackedScene = load("res://scenes/battle_system/actions_menu/actions_menu.tscn")

	var actions_menu: ActionsMenu = actions_menu_scene.instantiate()

	actions_menu.unit = init_unit
	actions_menu.unit_stations = init_unit_stations
	actions_menu.dialogue_box = init_dialogue_box
	actions_menu.control_index_memory = init_control_index_memory

	## any global resource should be an input (, mirror_cast_resource: int)
		## only used to check if a skill is usable

	return actions_menu

func _ready():
	build_action_menus()

func build_action_menus():
	hide()

	unit.cost_previews_on = false

	destroy_group("actions_menu_button")

	for type in Intent.Action.Type:
		match type:
			"BASIC_ATTACK":
				var button:= AttackMenuButton.new()
				button.action_chosen.connect(_on_action_chosen)
				button.dialogue_change.connect(dialogue_box._on_dialogue_change)
				button.last_control_focus.connect(_on_last_control_focus)
				add_child(button)
			"DEFEND":
				var button:= DefendMenuButton.new()
				button.action_chosen.connect(_on_action_chosen)
				button.dialogue_change.connect(dialogue_box._on_dialogue_change)
				button.last_control_focus.connect(_on_last_control_focus)
				add_child(button)
			"SKILL":
				var button:= ActionsMenuButton.new()
				button.text = "Skill"
				button.pressed.connect(build_skill_menus)
				button.focus_entered.connect(func (): 
					button.dialogue_change.emit("Skill")
					button.last_control_focus.emit("Action", button)
					)
				button.dialogue_change.connect(dialogue_box._on_dialogue_change)
				button.last_control_focus.connect(_on_last_control_focus)
				add_child(button)
			"MIRROR_CAST":
				pass
			"ITEM":
				pass

	spacing_and_focus(get_tree().get_nodes_in_group("actions_menu_button"), "Action")

	show()

func build_skill_menus():
	hide()

	destroy_group("actions_menu_button")

	for skill_id in unit.skills_store_player.active_skills:
		var skills_store: PartyMember.SkillsStore.SkillStore = unit.skills_store_player.active_skills[skill_id] 

		var button:= SkillMenuButton.new(skills_store.id, skills_store.level, unit)
		button.action_chosen.connect(_on_action_chosen)
		button.dialogue_change.connect(dialogue_box._on_dialogue_change)
		button.last_control_focus.connect(_on_last_control_focus)
		add_child(button)

	var back_button = BackMenuButton.new(unit)
	back_button.pressed.connect(build_action_menus)
	back_button.dialogue_change.connect(dialogue_box._on_dialogue_change)
	add_child(back_button)

	spacing_and_focus(get_tree().get_nodes_in_group("actions_menu_button"), "Skill")

	show()

func build_target_menus():

	var potential_targets:= Target_Funcs.find_potential_targets(unit, chosen_intent.action, unit_stations)

	var target_controller_home = Node2D.new()
	target_controller_home.add_to_group("target_controller_home")

	for target in potential_targets:
		var target_controller = TargetController.new(target)
		target_controller.target_chosen.connect(_on_target_chosen)
		target_controller.target_back.connect(_on_target_back)
		target_controller.last_control_focus.connect(_on_last_control_focus)
		target_controller_home.add_child(target_controller)

	add_child(target_controller_home)

	var target_controllers:= get_tree().get_nodes_in_group("target_controller")

	setup_focus(target_controllers, "Target")

func _on_action_chosen(action: Intent.Action):
	for n in get_tree().get_nodes_in_group("actions_menu_button"):
		n.hide()
	
	chosen_intent.action = action
	build_target_menus()

func _on_target_chosen(target: Intent.Target, target_controller: TargetController):
	target_controller.release_focus()
	set_finalized_target(target)
	
	if !chosen_intent.target:
		chosen_intent.target = target
		match target.meta.number:
			ActiveSkill.Target.TargetNumber.TWO:
				build_target_menus()
			_:
				destroy_group("target_controller")
				destroy_group("target_controller_home")
				intent_chosen.emit(chosen_intent)

	else:
		chosen_intent.target.additional_targets = target.main_targets
		destroy_group("target_controller")
		destroy_group("target_controller_home")
		print("emit intent")
		intent_chosen.emit(chosen_intent)

func _on_target_back(target_controller: TargetController):
	target_controller.release_focus()
	destroy_group("target_controller")
	destroy_group("target_controller_home")

	if !chosen_intent.target:
		for n in get_tree().get_nodes_in_group("actions_menu_button"):
			n.show()
		
		## not ideal, but should be fine. Cant swap initial action options though, but wasnt planning on that anyways
		if control_index_memory.has("Action"):
			if control_index_memory["Action"] == 0 or control_index_memory["Action"] == 1:
				setup_focus(get_tree().get_nodes_in_group("actions_menu_button"), "Action")
			elif control_index_memory["Action"] == 2:
				setup_focus(get_tree().get_nodes_in_group("actions_menu_button"), "Skill")
	
	else:
		unset_finalized_target(chosen_intent.target)
		chosen_intent.target = null
		build_target_menus()

func spacing_and_focus(buttons:Array[Node], group: String):
	var y_offset:= 0
	var distance_between:= 40

	for button in buttons:
		button.position.y = y_offset
		y_offset+= distance_between

	setup_focus(buttons, group)

func setup_focus(buttons: Array[Node], group: String):
	for i in range(buttons.size()):
		var node: Control = buttons[i]
		node.set_focus_mode(Control.FOCUS_ALL)

		if i == 0:
			# node.grab_focus()
			node.set_focus_neighbor(SIDE_TOP, buttons[buttons.size() - 1].get_path())
		else:
			node.set_focus_neighbor(SIDE_TOP, buttons[i - 1].get_path())

		if i < (buttons.size() - 1):
			node.set_focus_neighbor(SIDE_BOTTOM, buttons[i + 1].get_path())
		else:
			node.set_focus_neighbor(SIDE_BOTTOM, buttons[0].get_path())

	if control_index_memory.has(group):
		if control_index_memory[group] < buttons.size():
			buttons[control_index_memory[group]].grab_focus()
		else:
			buttons[0].grab_focus()	
	else:
		buttons[0].grab_focus()		

func destroy_group(group_name: String):
	for n in get_tree().get_nodes_in_group(group_name):
		remove_child(n)
		n.queue_free()

func set_finalized_target(target: Intent.Target):
	for target_store in target.main_targets:
		var node: BattleUnit = get_node(target_store.node_path)
		node.finalized_as_target = true
	for target_store in target.additional_targets:
		var node: BattleUnit = get_node(target_store.node_path)
		node.finalized_as_target = true

func unset_finalized_target(target: Intent.Target):
	for target_store in target.main_targets:
		var node: BattleUnit = get_node(target_store.node_path)
		node.finalized_as_target = false
	for target_store in target.additional_targets:
		var node: BattleUnit = get_node(target_store.node_path)
		node.finalized_as_target = false

func _on_last_control_focus(group: String, control: Control):
	control_index_memory[group] = control.get_index()
