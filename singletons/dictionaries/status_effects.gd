extends Node

var DICTIONARY:= {}

# EXAMPLE: to clean up the dict modifications.
# func add_effect2(effect_id: String, effect: StatusEffect):
# 	effect.initialize(DICTIONARY) # for example, allow status effects to take the DICTIONARY as a param and mutate it.
# 	DICTIONARY[effect_id] = effect

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

func _ready():
	add_effect("SE_0", "default")

	add_effect("SE_1", "stat_test_buff_1")
	DICTIONARY.SE_1.base_stat_multiplier_function = func(base_stats: Stats.BaseStats, _level) -> Stats.BaseStats:
		var res:= DeepCopy.copy_base_stats(base_stats)
		res.physical.attack *= 1.5
		res.magical.attack *= 1.5
		return res
	DICTIONARY.SE_1.base_stat_adder_function = func(base_stats: Stats.BaseStats, _level) -> Stats.BaseStats:
		var res:= DeepCopy.copy_base_stats(base_stats)
		res.physical.defense += 20
		return res
	
	add_effect("SE_2", "stat_test_buff_2")
	DICTIONARY.SE_2.base_stat_adder_function = func(base_stats: Stats.BaseStats, _level) -> Stats.BaseStats:
		var res:= DeepCopy.copy_base_stats(base_stats)
		res.magical.attack += 20
		return res

	add_effect("SE_Taunt", "taunt test")
	DICTIONARY.SE_Taunt.optional_properties= {"taunt": true}
	
	# add_effect("SE_3", "poison number 1", Poison.new())
	# DICTIONARY.SE_3.on_damage_taken = func()
		
	
#all status effecst must implement StatusEffect class
# class Poison implements StatusEffect {
#   func add_effect() {
#	DICTIONARY.SE_3.effect_on_count_down = func(base_stats: Stats.BaseStats, _level) -> Stats.BaseStats:
		# var res:= DeepCopy.copy_base_stats(base_stats)
		# res..attack += 20
		# return res
#}
#}

# class CurablePoison implements Poison {
# 	func onDamage
# }