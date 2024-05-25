class_name BattleSystem
extends Node

signal turn_order_change(units_in_turn_order: Array[BattleUnit])

var main: Node
var party: Dictionary
var encounter: Encounter

var battle_over:= false
var drops #Dict = key (Item ID): value (quantity)
var turn_count := 0

var units_in_turn_order: Array[BattleUnit]:
	set(new_units_in_turn_order):
		turn_order_change.emit(new_units_in_turn_order)
		units_in_turn_order = new_units_in_turn_order

static func new_battle(init_party: Dictionary, init_encounter: Encounter) -> BattleSystem:
	var battle_system_scene: PackedScene = load("res://scenes/battle_system/battle_system.tscn")

	var battle_system: BattleSystem = battle_system_scene.instantiate()

	battle_system.party = init_party
	battle_system.encounter = init_encounter

	return battle_system

func _ready():
	main = get_parent()
	main.battle_ready.connect(_on_battle_ready)

func _on_battle_ready():

	initial_unit_spawn()

	turn()

# every time an action is taken, run check_for_battle_over()


func initial_unit_spawn():

	##add battle start status effect logic

	for party_member in party:
		var unit_instance = BattlePlayerUnit.new_player_unit(party[party_member])
		unit_instance.unit_died.connect(_on_unit_death)
		unit_instance.add_to_group("ally")
		unit_instance.add_to_group("player")
		$UnitStations/Real/Player.add_child(unit_instance)

	for enemy in encounter.enemies:
		var real_unit_instance = BattleEnemyUnit.new_enemy_unit(enemy, false)
		real_unit_instance.unit_died.connect(_on_unit_death)
		real_unit_instance.add_to_group("enemy")
		real_unit_instance.add_to_group("real_enemy")
		$UnitStations/Real/Enemy.add_child(real_unit_instance)	
		
		var mirror_unit_instance = BattleEnemyUnit.new_enemy_unit(enemy, true)
		mirror_unit_instance.unit_died.connect(_on_unit_death)
		mirror_unit_instance.add_to_group("enemy")
		mirror_unit_instance.add_to_group("mirror_enemy")
		$UnitStations/Mirror/Enemy.add_child(mirror_unit_instance)	

func turn():
	turn_count += 1
	units_in_turn_order = CreateTurnOrder.initial(turn_count, GetUnits.all_units($UnitStations))

	#Non-player Intents
	for unit in units_in_turn_order:
		if !unit.stats.player:
			unit.intent = Intent.new() ## replace with AI
			## enemy AI and non player ally sprites -> display intents over all non player sprites sprites
				## for node in enemy stations:
					## switch node.intent.action.type

	##Action
	for unit in units_in_turn_order:
		unit.units_turn = true

		##beginning of turn status effect logic








		var chosen_intent: Intent

		##TAUNT TEST
		# var taunt_store:= Stats.StatusEffectStore.new("SE_Taunt", 0)
		# taunt_store.optional_node_store = [$UnitStations/Real/Enemy.get_child(0)]
		# unit.stats.add_status_effect(taunt_store)

		##INVIS TEST
		# var invis_store:= Stats.StatusEffectStore.new("SE_Invis", 99)
		# var en = $UnitStations/Real/Enemy.get_child(0)
		# en.stats.add_status_effect(invis_store)
		
		if unit.stats.can_act:
			if !unit.stats.player:
				chosen_intent = unit.intent
			else:
				var actions_menu_instance:= ActionsMenu.new_actions_menu(unit, $UnitStations, $DialogueBox, unit.control_index_memory)
				add_child(actions_menu_instance)
				print("awaiting intent")
				chosen_intent =	await actions_menu_instance.intent_chosen
				remove_child(actions_menu_instance)
				actions_menu_instance.queue_free()
			
		if chosen_intent:
			if chosen_intent.target:
				set_finalized_target(chosen_intent.target)
			
			if !unit.stats.player:
				##add logic for if chosen target is gone (only applicable for AI)
				pass

			match chosen_intent.action.type:
				Intent.Action.Type.BASIC_ATTACK:
					pass
				Intent.Action.Type.DEFEND:
					pass
				Intent.Action.Type.SKILL:
					##is await necessary?
					await ProcessSkill.process_skill(unit, chosen_intent, $UnitStations)
				Intent.Action.Type.MIRROR_CAST:
					pass
				Intent.Action.Type.ITEM:
					##process item
					##Inventory.use_item()
					pass


			## ideally should remove this after enemy AI is implemented
			if chosen_intent.target:
				unset_finalized_target(chosen_intent.target)

		##handle deaths (redo turn order and enemy intent targets)
			## if player -> put in deaths door
				## if not -> handle deletion
			## enemy -> drops/rewards
		

		#add end of turn status effect logic
		##handle deaths again
		
		unit.intent = null ##clear intent
		unit.units_turn = false


func _process(delta):
	if(battle_over):
		pass

func _on_unit_death(unit: BattleUnit):
	#if player/enemy

	#for status effect in status effects
		#match
			#check for explode/others

	##update turn order to remove unit
	pass
	

func set_finalized_target(target: Intent.Target):
	for node_path: NodePath in target.node_paths:
		var node: BattleUnit = get_node(node_path)
		node.finalized_as_target = true
	for node_path: NodePath in target.additional_targets:
		var node: BattleUnit = get_node(node_path)
		node.finalized_as_target = true

func unset_finalized_target(target: Intent.Target):
	for node_path: NodePath in target.node_paths:
		var node: BattleUnit = get_node(node_path)
		node.finalized_as_target = false
	for node_path: NodePath in target.additional_targets:
		var node: BattleUnit = get_node(node_path)
		node.finalized_as_target = false
		
