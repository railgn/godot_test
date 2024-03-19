extends Node

var DICTIONARY:= {}

func add_party_member(init_character_id: String, init_class_id: String, init_promoted: bool) -> void:
	if DICTIONARY.has(init_character_id):
		print("DUPLICATE PARTY MEMBER: ", init_character_id, " ", init_class_id, " ", init_promoted)
	else:
		DICTIONARY[init_character_id] = PartyMember.new(init_character_id, init_class_id, init_promoted)

func get_character(id: String) -> PartyMember:
	if DICTIONARY.has(id):
		return DICTIONARY[id]
	else:
		print("PARTY MEMBER DOES NOT EXIST: ", id)
		return PartyMember.new("P_0", "BC_0", false)

func _ready():
	add_party_member("P_0", "BC_0", false)

	add_party_member("P_1", "BC_1", false)