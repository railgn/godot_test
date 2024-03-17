extends Node

var DICTIONARY = {}

func add_character_class(init_id: String, init_name: String, init_promoted: bool) -> void:
	if DICTIONARY.has(init_id):
		print("DUPLICATE CLASS: ", init_id, " ", init_name, " ", init_promoted)
	else:
		DICTIONARY[init_id] = CharacterClass.new(init_id, init_name, init_promoted)

func get_character_class(id: String) -> CharacterClass:
	if DICTIONARY.has(id):
		return DICTIONARY[id]
	else:
		print("SKILL DOES NOT EXIST: ", id)
		return CharacterClass.new("BC0", "default", false)

func _ready():
	add_character_class("BC0", "default", false)