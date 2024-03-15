extends Node

var DICTIONARY:= {}

func add_effect(init_id: String, init_name: String):
	if DICTIONARY.has(init_id):
		print("DUPLICATE STATUS EFFECT: ", init_id, " ", init_name)
	else:
		DICTIONARY[init_id] = StatusEffect.new(init_id, init_name)

func get_effect(id: String) -> StatusEffect:
	if DICTIONARY.has(id):
		return DICTIONARY[id]
	else:
		print("STATUS EFFECT DOES NOT EXIST: ", id)
		return StatusEffect.new("SE_0", "default")

# func edit_effect(id, property, value):

# signal initialized

func _ready():
	add_effect("SE_0", "default")

	add_effect("SE_1", "stat_test_buff_1")
	DICTIONARY.SE_1.stat_multiplier_function = func(base_stats: Stats.BaseStats, _level) -> Stats.BaseStats:
		var res:= DeepCopy.copy_base_stats(base_stats)
		res.physical.attack *= 1.5
		res.magical.attack *= 1.5
		return res
	DICTIONARY.SE_1.stat_adder_function = func(base_stats: Stats.BaseStats, _level) -> Stats.BaseStats:
		var res:= DeepCopy.copy_base_stats(base_stats)
		res.physical.defense += 20
		return res
	
	add_effect("SE_2", "stat_test_buff_2")
	DICTIONARY.SE_2.stat_adder_function = func(base_stats: Stats.BaseStats, _level) -> Stats.BaseStats:
		var res:= DeepCopy.copy_base_stats(base_stats)
		res.magical.attack += 20
		return res

	# call_deferred("emit_signal", "initialized")