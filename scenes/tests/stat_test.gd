extends Node

var stats_test: Stats
var DEEP_COPY = DeepCopy.new()

func _ready():
	# StatusEffects.initialized.connect(_on_autoload_initialized)

# func _on_autoload_initialized():
	stats_test = Stats.new()

	##proxy for getting a status effect from a skill
	var new_effect_1 := Stats.StatusEffectStore.new("SE_1", 3)
	
	stats_test.add_status_effect(new_effect_1)
	stats_test.add_status_effect(new_effect_1)
	stats_test.add_status_effect(new_effect_1)
	stats_test.add_status_effect(new_effect_1)

	var new_effect_2 := Stats.StatusEffectStore.new("SE_2", 1)
	stats_test.add_status_effect(new_effect_2)
	stats_test.add_status_effect(new_effect_2)

	var new_effect_3 := Stats.StatusEffectStore.new("SE_0", 0)
	new_effect_3.id = "SE_0"
	new_effect_3.turns_left = 0
	stats_test.add_status_effect(new_effect_3)
	stats_test.add_status_effect(new_effect_3)
	stats_test.add_status_effect(new_effect_3)
	
	print("--- STAT TEST ---")
	var test_1 = stats_test.combat_stats.physical.attack == 1.5
	# print("Stat Test Multiply --- Combat Physical Attack = 1.5: ", test_1)
	var test_2 = stats_test.combat_stats.physical.defense == 21
	# print("Stat Test Addition --- Combat Physical Defebse = 21: ", test_2)
	var test_3 = stats_test.combat_stats.magical.attack == 31.5
	# print("Stat Test Multiply + Addition --- Combat Magic Attack = 31.5: ", test_3)
	var test_4 = "SE_0" not in stats_test.status_effects_store.keys()
	# print("Stat Test Delete Exipired Keys --- SE_0 Deleted: ", test_4)
	
	var new_mapping_stats:= DEEP_COPY.copy_mapping_stats(stats_test.mapping_stats)
	new_mapping_stats.strength = 2
	stats_test.mapping_stats = new_mapping_stats
	var test_5 = stats_test.combat_stats.physical.attack == 3
	# print("Mapping Stat Update --- Combat Physical Attack = 3: ", test_5)

	print("PASS" if (test_1 and test_2 and test_3 and test_4 and test_5) else "FAIL")
	print("")