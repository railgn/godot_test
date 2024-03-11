extends Node

var stats_test: Stats


func _ready():
	# StatusEffects.initialized.connect(_on_autoload_initialized)

# func _on_autoload_initialized():
	stats_test = Stats.new()

	var new_effect := Stats.StatusEffectStore.new()
	new_effect.id = "SE_1"
	new_effect.turns_left = 3

	stats_test.add_status_effect(new_effect)
	stats_test.add_status_effect(new_effect)
	stats_test.add_status_effect(new_effect)
	stats_test.add_status_effect(new_effect)

	print("Physical Attack = 1.5: ", (stats_test.combat_stats.physical.attack == 1.5))
