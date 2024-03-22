extends Node

var DICTIONARY:= {}

# func add_equipment(init_id: String, init_name: String, init_type: bool) -> void:
# 	if DICTIONARY.has(init_id):
# 		print("DUPLICATE SKILL: ", init_id, " ", init_name, init_type)
# 	else:
# 		if init_type:
# 			DICTIONARY[init_id] = ActiveSkill.new(init_id, init_name, init_type)
# 		else:
# 			DICTIONARY[init_id] = PassiveSkill.new(init_id, init_name, init_type)


# func get_equipment(id: String) -> Skill:
# 	if DICTIONARY.has(id):
# 		return DICTIONARY[id]
# 	else:
# 		print("SKILL DOES NOT EXIST: ", id)
# 		return ActiveSkill.new("SK_0", "default", true)

# func _ready():
# 	add_equipment("SK_0", "default", true)
	
# 	add_equipment("SK_1", "passive stat test", false)
# 	DICTIONARY.SK_1.status_effect_granted.id = "SE_1"