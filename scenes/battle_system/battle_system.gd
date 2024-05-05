class_name BattleSystem
extends Node

# const battle_system_scene: PackedScene = preload("res://scenes/battle_system/battle_system.tscn")

var main: Node
var party: Dictionary
var encounter: Encounter

var battle_over:= false
var drops #Dict = key (Item ID): value (quantity)
var turn := 0

static func new_battle(init_party: Dictionary, init_encounter: Encounter) -> BattleSystem:
	var battle_system_scene: PackedScene = load("res://scenes/battle_system/battle_system.tscn")

	var battle_system: BattleSystem = battle_system_scene.instantiate()

	battle_system.party = init_party
	battle_system.encounter = init_encounter

	return battle_system

func _ready():
	main = get_parent()
	main.start_battle_signal.connect(_on_start_battle_signal)

func _on_start_battle_signal():

	for party_member in party:
		var unit_instance = BattlePlayerUnit.new_player_unit(party[party_member])
		$UnitStations/Real/Player.add_child(unit_instance)

	for enemy in encounter.enemies:
		var real_unit_instance = BattleEnemyUnit.new_enemy_unit(enemy, false)
		$UnitStations/Real/Enemy.add_child(real_unit_instance)	
		
		var mirror_unit_instance = BattleEnemyUnit.new_enemy_unit(enemy, true)
		$UnitStations/Mirror/Enemy.add_child(mirror_unit_instance)	

	start_turn()

# every time an action is taken, run check_for_battle_over()

func start_turn():
	turn += 1
	var ordered_units = set_turn_order(turn, GetUnits.all_units($UnitStations))




func set_turn_order(current_turn, all_units: Array[BattleUnit]) -> Array[BattleUnit]:
	var res: Array[BattleUnit]= []

	var turn_order_obj = {}
	var turn_order_arr = []

	for unit in all_units:
		if !unit.stats.ally and unit.stats.mirror and unit.turn_initialized == current_turn:
			continue

		var turn_speed = unit.stats.combat_stats.turn_speed * (1.0 + randf() * 0.5)
		turn_order_obj[turn_speed] = unit
		turn_order_arr.append(turn_speed)

	
	turn_order_arr.sort_custom(func(a, b): return a > b)
	print(turn_order_arr)

	for speed in turn_order_arr:
		res.append(turn_order_obj[speed])

	return res

func _process(delta):
	if(battle_over):
		pass

	

	
		
