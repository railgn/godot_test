extends Node

var DICTIONARY:= {}

func add_skill(init_id: String, init_name: String, init_active: bool) -> void:
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

func _ready():
	add_skill("SK_0", "Attack", true)
	DICTIONARY.SK_0.description = "Basic Attack"

	
	add_skill("SK_1", "passive stat test", false)
	DICTIONARY.SK_1.status_effect_granted.id = "SE_1"

	add_skill("SK_TargetTest1", "Target Self", true)
	DICTIONARY.SK_TargetTest1.target.type = ActiveSkill.Target.TargetType.SELF
	
	add_skill("SK_TargetTest2", "Target Ally, Same Side, Single", true)
	DICTIONARY.SK_TargetTest2.target.type = ActiveSkill.Target.TargetType.ALLY

	add_skill("SK_TargetTest3", "Target Ally, Same Side, All", true)
	DICTIONARY.SK_TargetTest3.target.type = ActiveSkill.Target.TargetType.ALLY
	DICTIONARY.SK_TargetTest3.target.number = ActiveSkill.Target.TargetNumber.ALL

	add_skill("SK_TargetTest4", "Target Ally, Same Side, Adjacent", true)
	DICTIONARY.SK_TargetTest4.target.type = ActiveSkill.Target.TargetType.ALLY
	DICTIONARY.SK_TargetTest4.target.number = ActiveSkill.Target.TargetNumber.ADJACENT

	add_skill("SK_TargetTest5", "Target Enemy, Same Side, Single", true)

	add_skill("SK_TargetTest6", "Target Enemy, Same Side, All", true)
	DICTIONARY.SK_TargetTest6.target.number = ActiveSkill.Target.TargetNumber.ALL

	add_skill("SK_TargetTest7", "Target Enemy, Same Side, Adjacent", true)
	DICTIONARY.SK_TargetTest7.target.number = ActiveSkill.Target.TargetNumber.ADJACENT

	add_skill("SK_TargetTest8", "Target Enemy, Opposite Side, Single", true)
	DICTIONARY.SK_TargetTest8.target.side = ActiveSkill.Target.TargetSide.OPPOSITE

	add_skill("SK_TargetTest9", "Target Enemy, Opposite Side, All", true)
	DICTIONARY.SK_TargetTest9.target.side = ActiveSkill.Target.TargetSide.OPPOSITE
	DICTIONARY.SK_TargetTest9.target.number = ActiveSkill.Target.TargetNumber.ALL

	add_skill("SK_TargetTest10", "Target Enemy, Opposite Side, Adjacent", true)
	DICTIONARY.SK_TargetTest10.target.side = ActiveSkill.Target.TargetSide.OPPOSITE
	DICTIONARY.SK_TargetTest10.target.number = ActiveSkill.Target.TargetNumber.ADJACENT

	add_skill("SK_TargetTest11", "Target Enemy, Opposite Side, All_Side", true)
	DICTIONARY.SK_TargetTest11.target.side = ActiveSkill.Target.TargetSide.OPPOSITE
	DICTIONARY.SK_TargetTest11.target.number = ActiveSkill.Target.TargetNumber.ALL_SIDE
	
	add_skill("SK_TargetTest12", "Target Any, Same Side, Single", true)
	DICTIONARY.SK_TargetTest12.target.type = ActiveSkill.Target.TargetType.ANY
	DICTIONARY.SK_TargetTest12.target.side = ActiveSkill.Target.TargetSide.SAME
	DICTIONARY.SK_TargetTest12.target.number = ActiveSkill.Target.TargetNumber.ONE
	
	add_skill("SK_TargetTest13", "Target Any, Both Sides, Single", true)
	DICTIONARY.SK_TargetTest13.target.type = ActiveSkill.Target.TargetType.ANY
	DICTIONARY.SK_TargetTest13.target.side = ActiveSkill.Target.TargetSide.BOTH
	DICTIONARY.SK_TargetTest13.target.number = ActiveSkill.Target.TargetNumber.ONE
	
	add_skill("SK_TargetTest14", "Target Any, Both Sides, All side split", true)
	DICTIONARY.SK_TargetTest14.target.type = ActiveSkill.Target.TargetType.ANY
	DICTIONARY.SK_TargetTest14.target.side = ActiveSkill.Target.TargetSide.BOTH
	DICTIONARY.SK_TargetTest14.target.number = ActiveSkill.Target.TargetNumber.ALL_SIDE_SPLIT

	add_skill("SK_TargetTest15", "Target Any, Both Sides, All side", true)
	DICTIONARY.SK_TargetTest15.target.type = ActiveSkill.Target.TargetType.ANY
	DICTIONARY.SK_TargetTest15.target.side = ActiveSkill.Target.TargetSide.BOTH
	DICTIONARY.SK_TargetTest15.target.number = ActiveSkill.Target.TargetNumber.ALL_SIDE

	add_skill("SK_TargetTest16", "Target Any, Both Sides, All", true)
	DICTIONARY.SK_TargetTest16.target.type = ActiveSkill.Target.TargetType.ANY
	DICTIONARY.SK_TargetTest16.target.side = ActiveSkill.Target.TargetSide.BOTH
	DICTIONARY.SK_TargetTest16.target.number = ActiveSkill.Target.TargetNumber.ALL
	
	add_skill("SK_TargetTest17", "Target Enemy, Same Side, Two Test", true)
	DICTIONARY.SK_TargetTest17.target.type = ActiveSkill.Target.TargetType.ENEMY
	DICTIONARY.SK_TargetTest17.target.side = ActiveSkill.Target.TargetSide.SAME
	DICTIONARY.SK_TargetTest17.target.number = ActiveSkill.Target.TargetNumber.TWO
	DICTIONARY.SK_TargetTest17.cost.amount = func(skill_level, _resource, _user) -> int: return skill_level * 5 


	## Any unit. Both side

