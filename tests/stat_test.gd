extends Node

var stats_test: Stats

func _ready():
	# StatusEffects.initialized.connect(_on_autoload_initialized)

# func _on_autoload_initialized():
	stats_test = Stats.new()

	##proxy for getting a status effect from a skill
	var new_effect_1 := Stats.StatusEffectStore.new()
	new_effect_1.id = "SE_1"
	new_effect_1.turns_left = 3

	stats_test.add_status_effect(new_effect_1)
	stats_test.add_status_effect(new_effect_1)
	stats_test.add_status_effect(new_effect_1)
	stats_test.add_status_effect(new_effect_1)

	var new_effect_2 := Stats.StatusEffectStore.new()
	new_effect_2.id = "SE_2"
	new_effect_2.turns_left = 1
	stats_test.add_status_effect(new_effect_2)
	stats_test.add_status_effect(new_effect_2)

	var new_effect_3 := Stats.StatusEffectStore.new()
	new_effect_3.id = "SE_0"
	new_effect_3.turns_left = 0
	stats_test.add_status_effect(new_effect_3)
	stats_test.add_status_effect(new_effect_3)
	stats_test.add_status_effect(new_effect_3)

	print("Stat Test Multiply --- Combat Physical Attack = 1.5: ", (stats_test.combat_stats.physical.attack == 1.5))
	print("Stat Test Addition --- Combat Physical Defebse = 21: ", (stats_test.combat_stats.physical.defense == 21))
	print("Stat Test Multiply + Addition --- Combat Magic Attack = 31.5: ", (stats_test.combat_stats.magical.attack == 31.5))
	print("Stat Test Delete Exipired Keys --- SE_0 Deleted: ", ("SE_0" not in stats_test.status_effects.keys()))
