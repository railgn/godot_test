extends Node

var DICTIONARY = {}

func add_character(init_id: String, init_name: String, init_base_class: String) -> void:
	if DICTIONARY.has(init_id):
		print("DUPLICATE CHARACTER: ", init_id, " ", init_name, " ", init_base_class)
	else:
		DICTIONARY[init_id] = PlayableCharacter.new(init_id, init_name, init_base_class)

func get_character(id: String) -> PlayableCharacter:
	if DICTIONARY.has(id):
		return DICTIONARY[id]
	else:
		print("SKILL DOES NOT EXIST: ", id)
		return PlayableCharacter.new("P0", "default", "BC0")

func _ready():
	add_character("P0", "default", "BC0")