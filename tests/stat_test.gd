extends Node

var stats_test: Stats

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

	print("Stat Test Multiply --- Combat Physical Attack = 1.5: ", (stats_test.combat_stats.physical.attack == 1.5))
	print("Stat Test Addition --- Combat Physical Defebse = 21: ", (stats_test.combat_stats.physical.defense == 21))
	print("Stat Test Multiply + Addition --- Combat Magic Attack = 31.5: ", (stats_test.combat_stats.magical.attack == 31.5))
	print("Stat Test Delete Exipired Keys --- SE_0 Deleted: ", ("SE_0" not in stats_test.status_effects_store.keys()))


	var new_mapping_stats:= DeepCopy.copy_mapping_stats(stats_test.mapping_stats)
	new_mapping_stats.strength = 2

	stats_test.mapping_stats = new_mapping_stats

	print(stats_test.base_stats.physical.attack)
	print(stats_test.combat_stats.physical.attack)
