extends Node

var party_dictionary: Node


func _ready():
	party_dictionary = $party_dictionary
	party_dictionary.initialized.connect(on_party_initialized)

func on_party_initialized():

	print("--- PARTY TEST ---")

	var test_1 = party_dictionary.get_character("P_1").stats.combat_stats.physical.attack == 15
	# print("-- Default: ", test_1)
	# print("LEVEL --- P_0: ", party_dictionary.get_character("P_0").level," | P_1: ", party_dictionary.get_character("P_1").level )
	# print("CLASS --- P_0: ", party_dictionary.get_character("P_0").class_id," | P_1: ", party_dictionary.get_character("P_1").class_id)
	# print("STRENGTH --- P_0: ", party_dictionary.get_character("P_0").stats.mapping_stats.strength, " | P_1: ", party_dictionary.get_character("P_1").stats.mapping_stats.strength)
	# print("BASE PHYS ATK --- P_0: ", party_dictionary.get_character("P_0").stats.base_stats.physical.attack, " | P_1: ", party_dictionary.get_character("P_1").stats.base_stats.physical.attack)
	# print("MULT PHYS ATK --- P_0: ", party_dictionary.get_character("P_0").stats.base_stats_multiplier.physical.attack, " | P_1: ", party_dictionary.get_character("P_1").stats.base_stats_multiplier.physical.attack)
	# print("COMBAT PHYS ATK --- P_0: ", party_dictionary.get_character("P_0").stats.combat_stats.physical.attack, " | P_1: ", party_dictionary.get_character("P_1").stats.combat_stats.physical.attack)
	
	party_dictionary.DICTIONARY.P_1.class_id = "BC_0"
	var test_2 = party_dictionary.get_character("P_1").stats.combat_stats.physical.attack == 5
	# print("")
	# print("-- P1 Class Change to BC_0: ", test_2)
	# print("LEVEL --- P_0: ", party_dictionary.get_character("P_0").level," | P_1: ", party_dictionary.get_character("P_1").level )
	# print("CLASS --- P_0: ", party_dictionary.get_character("P_0").class_id," | P_1: ", party_dictionary.get_character("P_1").class_id)
	# print("STRENGTH --- P_0: ", party_dictionary.get_character("P_0").stats.mapping_stats.strength, " | P_1: ", party_dictionary.get_character("P_1").stats.mapping_stats.strength)
	# print("BASE PHYS ATK --- P_0: ", party_dictionary.get_character("P_0").stats.base_stats.physical.attack, " | P_1: ", party_dictionary.get_character("P_1").stats.base_stats.physical.attack)
	# print("MULT PHYS ATK --- P_0: ", party_dictionary.get_character("P_0").stats.base_stats_multiplier.physical.attack, " | P_1: ", party_dictionary.get_character("P_1").stats.base_stats_multiplier.physical.attack)
	# print("COMBAT PHYS ATK --- P_0: ", party_dictionary.get_character("P_0").stats.combat_stats.physical.attack, " | P_1: ", party_dictionary.get_character("P_1").stats.combat_stats.physical.attack)

	party_dictionary.DICTIONARY.P_1.level = 6
	var test_3 = party_dictionary.get_character("P_1").stats.combat_stats.physical.attack == 6
	# print("")
	# print("-- P1 Level Change to 6: ", test_3)
	# print("LEVEL --- P_0: ", party_dictionary.get_character("P_0").level," | P_1: ", party_dictionary.get_character("P_1").level )
	# print("CLASS --- P_0: ", party_dictionary.get_character("P_0").class_id," | P_1: ", party_dictionary.get_character("P_1").class_id)
	# print("STRENGTH --- P_0: ", party_dictionary.get_character("P_0").stats.mapping_stats.strength, " | P_1: ", party_dictionary.get_character("P_1").stats.mapping_stats.strength)
	# print("BASE PHYS ATK --- P_0: ", party_dictionary.get_character("P_0").stats.base_stats.physical.attack, " | P_1: ", party_dictionary.get_character("P_1").stats.base_stats.physical.attack)
	# print("MULT PHYS ATK --- P_0: ", party_dictionary.get_character("P_0").stats.base_stats_multiplier.physical.attack, " | P_1: ", party_dictionary.get_character("P_1").stats.base_stats_multiplier.physical.attack)
	# print("COMBAT PHYS ATK --- P_0: ", party_dictionary.get_character("P_0").stats.combat_stats.physical.attack, " | P_1: ", party_dictionary.get_character("P_1").stats.combat_stats.physical.attack)
	
	party_dictionary.DICTIONARY.P_1.class_id = "BC_1"
	var test_4 = party_dictionary.get_character("P_1").stats.combat_stats.physical.attack == 18
	# print("")
	# print("-- P1 Class Change to BC_1: ", test_4)
	# print("LEVEL --- P_0: ", party_dictionary.get_character("P_0").level," | P_1: ", party_dictionary.get_character("P_1").level )
	# print("CLASS --- P_0: ", party_dictionary.get_character("P_0").class_id," | P_1: ", party_dictionary.get_character("P_1").class_id)
	# print("STRENGTH --- P_0: ", party_dictionary.get_character("P_0").stats.mapping_stats.strength, " | P_1: ", party_dictionary.get_character("P_1").stats.mapping_stats.strength)
	# print("BASE PHYS ATK --- P_0: ", party_dictionary.get_character("P_0").stats.base_stats.physical.attack, " | P_1: ", party_dictionary.get_character("P_1").stats.base_stats.physical.attack)
	# print("MULT PHYS ATK --- P_0: ", party_dictionary.get_character("P_0").stats.base_stats_multiplier.physical.attack, " | P_1: ", party_dictionary.get_character("P_1").stats.base_stats_multiplier.physical.attack)
	# print("COMBAT PHYS ATK --- P_0: ", party_dictionary.get_character("P_0").stats.combat_stats.physical.attack, " | P_1: ", party_dictionary.get_character("P_1").stats.combat_stats.physical.attack)

	party_dictionary.DICTIONARY.P_1.add_equipment("EQ_1", 0)
	var test_5 = party_dictionary.get_character("P_1").stats.combat_stats.physical.attack == 19.5
	# print("")
	# print("-- P1 Add Equipment: ", test_5)
	# print("LEVEL --- P_0: ", party_dictionary.get_character("P_0").level," | P_1: ", party_dictionary.get_character("P_1").level )
	# print("CLASS --- P_0: ", party_dictionary.get_character("P_0").class_id," | P_1: ", party_dictionary.get_character("P_1").class_id)
	# print("STRENGTH --- P_0: ", party_dictionary.get_character("P_0").stats.mapping_stats.strength, " | P_1: ", party_dictionary.get_character("P_1").stats.mapping_stats.strength)
	# print("BASE PHYS ATK --- P_0: ", party_dictionary.get_character("P_0").stats.base_stats.physical.attack, " | P_1: ", party_dictionary.get_character("P_1").stats.base_stats.physical.attack)
	# print("MULT PHYS ATK --- P_0: ", party_dictionary.get_character("P_0").stats.base_stats_multiplier.physical.attack, " | P_1: ", party_dictionary.get_character("P_1").stats.base_stats_multiplier.physical.attack)
	# print("COMBAT PHYS ATK --- P_0: ", party_dictionary.get_character("P_0").stats.combat_stats.physical.attack, " | P_1: ", party_dictionary.get_character("P_1").stats.combat_stats.physical.attack)
	# print("")
	# print("-- Equip Mapping Add & Multiply: ", party_dictionary.get_character("P_1").stats.mapping_stats.intelligence == 80)
	# print("INTELLIGENCE --- P_0: ", party_dictionary.get_character("P_0").stats.mapping_stats.intelligence, " | P_1: ", party_dictionary.get_character("P_1").stats.mapping_stats.intelligence)
	
	party_dictionary.DICTIONARY.P_1.class_id = "BC_2"
	var test_6 = party_dictionary.get_character("P_1").stats.mapping_stats.intelligence == 80
	# print("")
	# print("-- P1 Change Class but Keep Equipment: ", test_6)
	# print("CLASS --- P_0: ", party_dictionary.get_character("P_0").class_id," | P_1: ", party_dictionary.get_character("P_1").class_id)
	# print("INTELLIGENCE --- P_0: ", party_dictionary.get_character("P_0").stats.mapping_stats.intelligence, " | P_1: ", party_dictionary.get_character("P_1").stats.mapping_stats.intelligence)

	party_dictionary.DICTIONARY.P_1.class_id = "BC_0"
	var test_7 = party_dictionary.get_character("P_1").stats.mapping_stats.intelligence == 6
	# print("")
	# print("-- P1 Change Class and Remove Equipment: ", test_7)
	# print("CLASS --- P_0: ", party_dictionary.get_character("P_0").class_id," | P_1: ", party_dictionary.get_character("P_1").class_id)
	# print("COMBAT PHYS ATK --- P_0: ", party_dictionary.get_character("P_0").stats.combat_stats.physical.attack, " | P_1: ", party_dictionary.get_character("P_1").stats.combat_stats.physical.attack)
	# print("INTELLIGENCE --- P_0: ", party_dictionary.get_character("P_0").stats.mapping_stats.intelligence, " | P_1: ", party_dictionary.get_character("P_1").stats.mapping_stats.intelligence)
	print("PASS" if (test_1 and test_2 and test_3 and test_4 and test_5 and test_6 and test_7) else "FAIL")

	print("")