class_name BattleSystem
extends Node

const battle_system_scene: PackedScene = preload("res://scenes/battle_system/battle_system.tscn")

var main: Node
var party: Dictionary
var encounter: Encounter

var battle_over:= false
var drops #Dict = key (Item ID): value (quantity)
var turn := 0

static func new_battle(init_party: Dictionary, init_encounter: Encounter) -> BattleSystem:
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
		$Real/Player.add_child(unit_instance)

	for enemy in encounter.enemies:
		var real_unit_instance = BattleEnemyUnit.new_enemy_unit(enemy, false)
		$Real/Enemy.add_child(real_unit_instance)	
		
		var mirror_unit_instance = BattleEnemyUnit.new_enemy_unit(enemy, true)
		$Mirror/Enemy.add_child(mirror_unit_instance)	


	#battle()


# while(!battle_over)

# every time an action is taken, run check_for_battle_over()
	

	
		
