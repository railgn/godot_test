extends Node

signal initialized

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
		print("CLASS DOES NOT EXIST: ", id)
		return CharacterClass.new("BC_0", "default", false)

func _ready():
	add_character_class("BC_0", "default", false)
	# DICTIONARY.BC_0.innate_skills.active_skills.SK_0 = PartyMember.SkillsStore.SkillStore.new("SK_0", 1)
	# DICTIONARY.BC_0.innate_skills.active_skills.SK_TargetTest1 = PartyMember.SkillsStore.SkillStore.new("SK_TargetTest1", 1)
	# DICTIONARY.BC_0.innate_skills.active_skills.SK_TargetTest2 = PartyMember.SkillsStore.SkillStore.new("SK_TargetTest2", 1)
	# DICTIONARY.BC_0.innate_skills.active_skills.SK_TargetTest3 = PartyMember.SkillsStore.SkillStore.new("SK_TargetTest3", 1)
	# DICTIONARY.BC_0.innate_skills.active_skills.SK_TargetTest4 = PartyMember.SkillsStore.SkillStore.new("SK_TargetTest4", 1)
	# DICTIONARY.BC_0.innate_skills.active_skills.SK_TargetTest5 = PartyMember.SkillsStore.SkillStore.new("SK_TargetTest5", 1)
	# DICTIONARY.BC_0.innate_skills.active_skills.SK_TargetTest6 = PartyMember.SkillsStore.SkillStore.new("SK_TargetTest6", 1)
	# DICTIONARY.BC_0.innate_skills.active_skills.SK_TargetTest7 = PartyMember.SkillsStore.SkillStore.new("SK_TargetTest7", 1)
	# DICTIONARY.BC_0.innate_skills.active_skills.SK_TargetTest8 = PartyMember.SkillsStore.SkillStore.new("SK_TargetTest8", 1)
	# DICTIONARY.BC_0.innate_skills.active_skills.SK_TargetTest9 = PartyMember.SkillsStore.SkillStore.new("SK_TargetTest9", 1)
	# DICTIONARY.BC_0.innate_skills.active_skills.SK_TargetTest10 = PartyMember.SkillsStore.SkillStore.new("SK_TargetTest10", 1)
	# DICTIONARY.BC_0.innate_skills.active_skills.SK_TargetTest11 = PartyMember.SkillsStore.SkillStore.new("SK_TargetTest11", 1)
	# DICTIONARY.BC_0.innate_skills.active_skills.SK_TargetTest12 = PartyMember.SkillsStore.SkillStore.new("SK_TargetTest12", 1)
	DICTIONARY.BC_0.innate_skills.active_skills.SK_TargetTest13 = PartyMember.SkillsStore.SkillStore.new("SK_TargetTest13", 1)
	DICTIONARY.BC_0.innate_skills.active_skills.SK_TargetTest14 = PartyMember.SkillsStore.SkillStore.new("SK_TargetTest14", 1)
	DICTIONARY.BC_0.innate_skills.active_skills.SK_TargetTest15 = PartyMember.SkillsStore.SkillStore.new("SK_TargetTest15", 1)
	DICTIONARY.BC_0.innate_skills.active_skills.SK_TargetTest16 = PartyMember.SkillsStore.SkillStore.new("SK_TargetTest16", 1)
	DICTIONARY.BC_0.innate_skills.active_skills.SK_TargetTest17 = PartyMember.SkillsStore.SkillStore.new("SK_TargetTest17", 1)

	add_character_class("BC_1", "party test", false)
	##probably safer to give an "add innate skills" func to CharacterClass
	DICTIONARY.BC_1.innate_skills.passive_skills.SK_1 = PartyMember.SkillsStore.SkillStore.new("SK_1", 2) 
	DICTIONARY.BC_1.mapping_stat_growths = func(level:int) -> Stats.MappingStats:
		var res_mapping_stats = Stats.MappingStats.new()

		res_mapping_stats.strength = level * 2  
		res_mapping_stats.intelligence = level * 1  
		res_mapping_stats.agility = level * 1  
		res_mapping_stats.dexterity = level * 1  
		res_mapping_stats.vitality = level * 1  
		res_mapping_stats.wisdom = level * 1  
		res_mapping_stats.luck = level * 1  

		return res_mapping_stats

	DICTIONARY.BC_1.equipment_slots.append(CharacterClass.Equipment_Slot.new([Equipment.EquipmentType.FOIL]))

	add_character_class("BC_2", "party test 2", false)
	DICTIONARY.BC_2.equipment_slots.append(CharacterClass.Equipment_Slot.new([Equipment.EquipmentType.FOIL]))

	call_deferred("emit_signal", "initialized")
	
