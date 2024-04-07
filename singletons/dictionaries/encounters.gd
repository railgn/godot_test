extends Node

var DICTIONARY:= {}

func add_encounter(init_id: String, init_enemies: Array[Encounter.EnemyData], init_battle_system:= "default") -> void:
	if DICTIONARY.has(init_id):
		print("DUPLICATE ENCOUNTER: ", init_id)
	else:
		DICTIONARY[init_id] = Encounter.new(init_id, init_enemies, init_battle_system)

func get_encounter(id: String) -> Encounter:
	if DICTIONARY.has(id):
		return DICTIONARY[id]
	else:
		print("ENCOUNTER DOES NOT EXIST: ", id)
		var enemies = [Encounter.EnemyData.new("E_0", 1)]

		return Encounter.new("ENC_0", enemies)

func _ready():
	var enemies:Array[Encounter.EnemyData] = [Encounter.EnemyData.new("E_0", 1)]
	add_encounter("ENC_0", enemies)
