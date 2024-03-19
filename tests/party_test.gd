extends Node

func _ready():
    Party.initialized.connect(on_party_initialized)

func on_party_initialized():

    print("--- PARTY TEST ---")
    print("P_0 level: ", Party.get_character("P_0").level,", P_1 level: ", Party.get_character("P_1").level )
    print("Party Test Level to Class Mapping --- Mapping Strength - P_0: ", Party.get_character("P_0").stats.mapping_stats.strength, ", P_1: ", Party.get_character("P_1").stats.mapping_stats.strength)
    print("Party Test Mapping to Base --- Base Phys Atk - P_0: ", Party.get_character("P_0").stats.base_stats.physical.attack, ", P_1: ", Party.get_character("P_1").stats.base_stats.physical.attack)
    print("Party Test Innate Class Skill to SE to Base Mult --- Mult Phys Atk - P_0: ", Party.get_character("P_0").stats.base_stats_multiplier.physical.attack, ", P_1: ", Party.get_character("P_1").stats.base_stats_multiplier.physical.attack)
    print("Party Test All to Combat --- Combat Phys Atk - P_0: ", Party.get_character("P_0").stats.combat_stats.physical.attack, ", P_1: ", Party.get_character("P_1").stats.combat_stats.physical.attack)