extends Node

var DICTIONARY:= {}

func add_skill(init_id: String, init_name: String, init_active: bool):
	if DICTIONARY.has(init_id):
		print("DUPLICATE SKILL: ", init_id, " ", init_name, init_active)
	else:
		if init_active:
			DICTIONARY[init_id] = ActiveSkill.new(init_id, init_name, init_active)
		else:
			DICTIONARY[init_id] = PassiveSkill.new(init_id, init_name, init_active)


func get_skill(id: String) -> Skill:
	if DICTIONARY.has(id):
		return DICTIONARY[id]
	else:
		print("SKILL DOES NOT EXIST: ", id)
		return ActiveSkill.new("SK_0", "default", true)


# func edit_effect(id, property, value):

# signal initialized

func _ready():
	add_skill("SK_0", "default", true)

	# call_deferred("emit_signal", "initialized")

