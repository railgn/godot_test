extends Node

var DICTIONARY:= {}

func add_encounter(init_id: String) -> void:
	if DICTIONARY.has(init_id):
		print("DUPLICATE ENCOUNTER: ", init_id)
	else:
		DICTIONARY[init_id] = Encounter.new()

func get_encounter(id: String) -> Encounter:
	if DICTIONARY.has(id):
		return DICTIONARY[id]
	else:
		print("ENCOUNTER DOES NOT EXIST: ", id)
		return Encounter.new()

func _ready():
	add_encounter("ENC_0")