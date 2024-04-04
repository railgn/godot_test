class_name Encounter

class EnemyData:
	var enemy_id: String
	var level: int
	var overrides: Dictionary

	func _init(init_enemy_id: String, init_level: int, init_overrides:= {}):
		enemy_id = init_enemy_id
		level = init_level
		overrides = init_overrides

var enemies: Array[EnemyData]
var battle_system_id: String
var environment_or_visual_template ## default to savedata location
var battle_end_conditions ##
var flag_triggers_on_completion ##