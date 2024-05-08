class_name BattleSystem
extends Node

signal turn_order_change()

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

var chosen_intent: Intent

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

	#loop await turns?

	turn()

# every time an action is taken, run check_for_battle_over()


func initial_unit_spawn():
	for party_member in party:
		var unit_instance = BattlePlayerUnit.new_player_unit(party[party_member])
		$UnitStations/Real/Player.add_child(unit_instance)

	for enemy in encounter.enemies:
		var real_unit_instance = BattleEnemyUnit.new_enemy_unit(enemy, false)
		$UnitStations/Real/Enemy.add_child(real_unit_instance)	
		
		var mirror_unit_instance = BattleEnemyUnit.new_enemy_unit(enemy, true)
		$UnitStations/Mirror/Enemy.add_child(mirror_unit_instance)	


func turn():
	turn_count += 1
	units_in_turn_order = CreateTurnOrder.initial(turn_count, GetUnits.all_units($UnitStations))

	#Non-player Intents
	for unit in units_in_turn_order:
		if !unit.stats.player:
			unit.intent = Intent.new() ## replace with AI
			## enemy AI and non player ally sprites -> display intents over all non player sprites sprites

	##Action
	for unit in units_in_turn_order:
		unit.units_turn = true
		chosen_intent = null	
		
		if unit.stats.can_act:
			if !unit.stats.player:
				chosen_intent = unit.intent
			else:
				var Actions_Menu:= ActionsMenu.new($UnitStations)
				
				add_child(Actions_Menu)
				#build actions menu
					#needs way of checking if skills are usable
						#cost
						#status effect conditions
						#special conditions (grave spawner max grave limit)

				#await action signal
					## dont even bother with this step? have action menu create target menu and just await for target selection?
				#hide actions menu (can show if they back out of target menu)
				var chosen_intent =	await Actions_Menu.intent_chosen

			
			if chosen_intent:
				#switch chosen_intent.action.type
					#await skill(ID, user, target)
						#await unit.play_animation

				##add logic for if chosen target is gone
				pass

			##handle deaths (redo turn order and enemy intent targets)


		#add end of turn status effect logic
		unit.intent = Intent.new() ##clear intent
		##handle deaths again
		unit.units_turn = false


func _process(delta):
	if(battle_over):
		pass

	

	
		
