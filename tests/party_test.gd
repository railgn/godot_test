extends Node

func _ready():
	Party.initialized.connect(on_party_initialized)

func on_party_initialized():

	print("")
	print("--- PARTY TEST ---")
	print("")
	print("-- Default: ", Party.get_character("P_1").stats.combat_stats.physical.attack == 15)
	print("LEVEL --- P_0: ", Party.get_character("P_0").level," | P_1: ", Party.get_character("P_1").level )
	print("CLASS --- P_0: ", Party.get_character("P_0").class_id," | P_1: ", Party.get_character("P_1").class_id)
	print("STRENGTH --- P_0: ", Party.get_character("P_0").stats.mapping_stats.strength, " | P_1: ", Party.get_character("P_1").stats.mapping_stats.strength)
	print("BASE PHYS ATK --- P_0: ", Party.get_character("P_0").stats.base_stats.physical.attack, " | P_1: ", Party.get_character("P_1").stats.base_stats.physical.attack)
	print("MULT PHYS ATK --- P_0: ", Party.get_character("P_0").stats.base_stats_multiplier.physical.attack, " | P_1: ", Party.get_character("P_1").stats.base_stats_multiplier.physical.attack)
	print("COMBAT PHYS ATK --- P_0: ", Party.get_character("P_0").stats.combat_stats.physical.attack, " | P_1: ", Party.get_character("P_1").stats.combat_stats.physical.attack)
	
	Party.DICTIONARY.P_1.class_id = "BC_0"
	print("")
	print("-- P1 Class Change to BC_0: ", Party.get_character("P_1").stats.combat_stats.physical.attack == 5)
	print("LEVEL --- P_0: ", Party.get_character("P_0").level," | P_1: ", Party.get_character("P_1").level )
	print("CLASS --- P_0: ", Party.get_character("P_0").class_id," | P_1: ", Party.get_character("P_1").class_id)
	print("STRENGTH --- P_0: ", Party.get_character("P_0").stats.mapping_stats.strength, " | P_1: ", Party.get_character("P_1").stats.mapping_stats.strength)
	print("BASE PHYS ATK --- P_0: ", Party.get_character("P_0").stats.base_stats.physical.attack, " | P_1: ", Party.get_character("P_1").stats.base_stats.physical.attack)
	print("MULT PHYS ATK --- P_0: ", Party.get_character("P_0").stats.base_stats_multiplier.physical.attack, " | P_1: ", Party.get_character("P_1").stats.base_stats_multiplier.physical.attack)
	print("COMBAT PHYS ATK --- P_0: ", Party.get_character("P_0").stats.combat_stats.physical.attack, " | P_1: ", Party.get_character("P_1").stats.combat_stats.physical.attack)

	Party.DICTIONARY.P_1.level = 6
	print("")
	print("-- P1 Level Change to 6: ", Party.get_character("P_1").stats.combat_stats.physical.attack == 6)
	print("LEVEL --- P_0: ", Party.get_character("P_0").level," | P_1: ", Party.get_character("P_1").level )
	print("CLASS --- P_0: ", Party.get_character("P_0").class_id," | P_1: ", Party.get_character("P_1").class_id)
	print("STRENGTH --- P_0: ", Party.get_character("P_0").stats.mapping_stats.strength, " | P_1: ", Party.get_character("P_1").stats.mapping_stats.strength)
	print("BASE PHYS ATK --- P_0: ", Party.get_character("P_0").stats.base_stats.physical.attack, " | P_1: ", Party.get_character("P_1").stats.base_stats.physical.attack)
	print("MULT PHYS ATK --- P_0: ", Party.get_character("P_0").stats.base_stats_multiplier.physical.attack, " | P_1: ", Party.get_character("P_1").stats.base_stats_multiplier.physical.attack)
	print("COMBAT PHYS ATK --- P_0: ", Party.get_character("P_0").stats.combat_stats.physical.attack, " | P_1: ", Party.get_character("P_1").stats.combat_stats.physical.attack)
	
	Party.DICTIONARY.P_1.class_id = "BC_1"
	
	print("")
	print("-- P1 Class Change to BC_1: ", Party.get_character("P_1").stats.combat_stats.physical.attack == 18)
	print("LEVEL --- P_0: ", Party.get_character("P_0").level," | P_1: ", Party.get_character("P_1").level )
	print("CLASS --- P_0: ", Party.get_character("P_0").class_id," | P_1: ", Party.get_character("P_1").class_id)
	print("STRENGTH --- P_0: ", Party.get_character("P_0").stats.mapping_stats.strength, " | P_1: ", Party.get_character("P_1").stats.mapping_stats.strength)
	print("BASE PHYS ATK --- P_0: ", Party.get_character("P_0").stats.base_stats.physical.attack, " | P_1: ", Party.get_character("P_1").stats.base_stats.physical.attack)
	print("MULT PHYS ATK --- P_0: ", Party.get_character("P_0").stats.base_stats_multiplier.physical.attack, " | P_1: ", Party.get_character("P_1").stats.base_stats_multiplier.physical.attack)
	print("COMBAT PHYS ATK --- P_0: ", Party.get_character("P_0").stats.combat_stats.physical.attack, " | P_1: ", Party.get_character("P_1").stats.combat_stats.physical.attack)

	Party.DICTIONARY.P_1.add_equipment("EQ_1", 0)
	print("")
	print("-- P1 Add Equipment: ", Party.get_character("P_1").stats.combat_stats.physical.attack == 19.5)
	print("LEVEL --- P_0: ", Party.get_character("P_0").level," | P_1: ", Party.get_character("P_1").level )
	print("CLASS --- P_0: ", Party.get_character("P_0").class_id," | P_1: ", Party.get_character("P_1").class_id)
	print("STRENGTH --- P_0: ", Party.get_character("P_0").stats.mapping_stats.strength, " | P_1: ", Party.get_character("P_1").stats.mapping_stats.strength)
	print("BASE PHYS ATK --- P_0: ", Party.get_character("P_0").stats.base_stats.physical.attack, " | P_1: ", Party.get_character("P_1").stats.base_stats.physical.attack)
	print("MULT PHYS ATK --- P_0: ", Party.get_character("P_0").stats.base_stats_multiplier.physical.attack, " | P_1: ", Party.get_character("P_1").stats.base_stats_multiplier.physical.attack)
	print("COMBAT PHYS ATK --- P_0: ", Party.get_character("P_0").stats.combat_stats.physical.attack, " | P_1: ", Party.get_character("P_1").stats.combat_stats.physical.attack)
	print("")
	print("-- EQUIP MAPPING ADD & MULT: ", Party.get_character("P_1").stats.mapping_stats.intelligence == 80)
	print("INTELLIGENCE --- P_0: ", Party.get_character("P_0").stats.mapping_stats.intelligence, " | P_1: ", Party.get_character("P_1").stats.mapping_stats.intelligence)

	Party.DICTIONARY.P_1.remove_equipment(0)
	print("")
	print("-- P1 Remove Equipment: ", Party.get_character("P_1").stats.combat_stats.physical.attack == 18)
	print("COMBAT PHYS ATK --- P_0: ", Party.get_character("P_0").stats.combat_stats.physical.attack, " | P_1: ", Party.get_character("P_1").stats.combat_stats.physical.attack)
