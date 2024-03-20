extends Node

func _ready():
	Party.initialized.connect(on_party_initialized)

func on_party_initialized():

	print("--- PARTY TEST ---")
	print("P_0 level: ", Party.get_character("P_0").level,", P_1 level: ", Party.get_character("P_1").level )
	print("Level to Class Mapping --- Mapping Strength - P_0: ", Party.get_character("P_0").stats.mapping_stats.strength, ", P_1: ", Party.get_character("P_1").stats.mapping_stats.strength)
	print("Mapping to Base --- Base Phys Atk - P_0: ", Party.get_character("P_0").stats.base_stats.physical.attack, ", P_1: ", Party.get_character("P_1").stats.base_stats.physical.attack)
	print("Innate Class Skill to SE to Base Mult --- Mult Phys Atk - P_0: ", Party.get_character("P_0").stats.base_stats_multiplier.physical.attack, ", P_1: ", Party.get_character("P_1").stats.base_stats_multiplier.physical.attack)
	print("All to Combat --- Combat Phys Atk - P_0: ", Party.get_character("P_0").stats.combat_stats.physical.attack, ", P_1: ", Party.get_character("P_1").stats.combat_stats.physical.attack)
	
	Party.DICTIONARY.P_1.class_id = "BC_0"
	print("--- P1 Class Change to BC_0 ---")
	print("Level to Class Mapping --- Mapping Strength - P_0: ", Party.get_character("P_0").stats.mapping_stats.strength, ", P_1: ", Party.get_character("P_1").stats.mapping_stats.strength)
	print("Mapping to Base --- Base Phys Atk - P_0: ", Party.get_character("P_0").stats.base_stats.physical.attack, ", P_1: ", Party.get_character("P_1").stats.base_stats.physical.attack)
	print("Innate Class Skill to SE to Base Mult --- Mult Phys Atk - P_0: ", Party.get_character("P_0").stats.base_stats_multiplier.physical.attack, ", P_1: ", Party.get_character("P_1").stats.base_stats_multiplier.physical.attack)
	print("All to Combat --- Combat Phys Atk - P_0: ", Party.get_character("P_0").stats.combat_stats.physical.attack, ", P_1: ", Party.get_character("P_1").stats.combat_stats.physical.attack)

	Party.DICTIONARY.P_1.level = 6
	print("--- P1 Level Change to 6---")
	print("Level to Class Mapping --- Mapping Strength - P_0: ", Party.get_character("P_0").stats.mapping_stats.strength, ", P_1: ", Party.get_character("P_1").stats.mapping_stats.strength)
	print("Mapping to Base --- Base Phys Atk - P_0: ", Party.get_character("P_0").stats.base_stats.physical.attack, ", P_1: ", Party.get_character("P_1").stats.base_stats.physical.attack)
	print("Innate Class Skill to SE to Base Mult --- Mult Phys Atk - P_0: ", Party.get_character("P_0").stats.base_stats_multiplier.physical.attack, ", P_1: ", Party.get_character("P_1").stats.base_stats_multiplier.physical.attack)
	print("All to Combat --- Combat Phys Atk - P_0: ", Party.get_character("P_0").stats.combat_stats.physical.attack, ", P_1: ", Party.get_character("P_1").stats.combat_stats.physical.attack)
	
	Party.DICTIONARY.P_1.class_id = "BC_1"
	print("--- P1 Class Change to BC_1---")
	print("Level to Class Mapping --- Mapping Strength - P_0: ", Party.get_character("P_0").stats.mapping_stats.strength, ", P_1: ", Party.get_character("P_1").stats.mapping_stats.strength)
	print("Mapping to Base --- Base Phys Atk - P_0: ", Party.get_character("P_0").stats.base_stats.physical.attack, ", P_1: ", Party.get_character("P_1").stats.base_stats.physical.attack)
	print("Innate Class Skill to SE to Base Mult --- Mult Phys Atk - P_0: ", Party.get_character("P_0").stats.base_stats_multiplier.physical.attack, ", P_1: ", Party.get_character("P_1").stats.base_stats_multiplier.physical.attack)
	print("All to Combat --- Combat Phys Atk - P_0: ", Party.get_character("P_0").stats.combat_stats.physical.attack, ", P_1: ", Party.get_character("P_1").stats.combat_stats.physical.attack)