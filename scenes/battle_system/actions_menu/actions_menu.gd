class_name ActionsMenu
extends Node2D

signal intent_chosen(intent: Intent)

var chosen_intent:= Intent.new()

var unit: BattlePlayerUnit

var unit_stations
var mirror_cast_resource
var dialogue_box

static func new_actions_menu(init_unit: BattlePlayerUnit, init_unit_stations, init_dialogue_box) -> ActionsMenu:
	var actions_menu_scene: PackedScene = load("res://scenes/battle_system/actions_menu/actions_menu.tscn")

	var actions_menu: ActionsMenu = actions_menu_scene.instantiate()

	actions_menu.unit = init_unit
	actions_menu.unit_stations = init_unit_stations
	actions_menu.dialogue_box = init_dialogue_box
	## any global resource should be an input (, mirror_cast_resource: int)
		## only used to check if a skill is usable

	return actions_menu

func _ready():
	build_action_menus()


func build_action_menus():
	hide()
	for n in get_children():
		remove_child(n)
		n.queue_free()

	for type in Intent.Action.Type:
		match type:
			"BASIC_ATTACK":
				var button:= AttackMenuButton.new()
				button.action_chosen.connect(_on_action_chosen)
				button.dialogue_change.connect(dialogue_box._on_dialogue_change)
				add_child(button)
			"DEFEND":
				var button:= DefendMenuButton.new()
				button.action_chosen.connect(_on_action_chosen)
				button.dialogue_change.connect(dialogue_box._on_dialogue_change)
				add_child(button)
			"SKILL":
				var button:= ActionsMenuButton.new()
				button.text = "Skill"
				button.pressed.connect(build_skill_menus)
				button.focus_entered.connect(func (): button.dialogue_change.emit("Skill"))
				button.dialogue_change.connect(dialogue_box._on_dialogue_change)
				add_child(button)
			"MIRROR_CAST":
				pass
			"ITEM":
				pass

	spacing_and_focus(get_children())

	show()

func build_skill_menus():
	hide()

	##abstract this
	for n in get_children():
		remove_child(n)
		n.queue_free()
	
	for skill_id in unit.skills_store_player.active_skills:
		var skills_store: PartyMember.SkillsStore.SkillStore = unit.skills_store_player.active_skills[skill_id] 

		var button:= SkillMenuButton.new(skills_store.id, unit)
		button.action_chosen.connect(_on_action_chosen)
		button.dialogue_change.connect(dialogue_box._on_dialogue_change)
		add_child(button)

	var back_button = BackMenuButton.new()
	back_button.pressed.connect(build_action_menus)
	back_button.dialogue_change.connect(dialogue_box._on_dialogue_change)
	add_child(back_button)

	spacing_and_focus(get_children())

	show()

func build_target_menus():
	## connect to signal
	##target back button needs to delete target menu then unhide non target menu
	pass

func _on_action_chosen(action: Intent.Action):
	for child in get_children():
		child.hide()
	
	chosen_intent.action = action
	build_target_menus()

func _on_target_chosen(target: Intent.Target):
	chosen_intent.target = target
	intent_chosen.emit(chosen_intent)

func spacing_and_focus(buttons:Array[Node]):
	var y_offset:= 0
	var distance_between:= 40

	for button in buttons:
		button.position.y = y_offset
		y_offset+= distance_between

		button.set_focus_mode(Control.FOCUS_ALL)

	for i in range(buttons.size()):
		var node: Button = buttons[i]

		if i == 0:
			node.grab_focus()
			node.set_focus_neighbor(SIDE_TOP, buttons[buttons.size() - 1].get_path())
		else:
			node.set_focus_neighbor(SIDE_TOP, buttons[i - 1].get_path())

		if i < (buttons.size() - 1):
			node.set_focus_neighbor(SIDE_BOTTOM, buttons[i + 1].get_path())
		else:
			node.set_focus_neighbor(SIDE_BOTTOM, buttons[0].get_path())

	
	buttons[0].grab_focus()


