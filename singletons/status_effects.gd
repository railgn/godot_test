extends Node

var DICTIONARY:= {}

class StatusEffect:
	var id:= "SE_0"
	var name:= "default"
	var description:= ""
	var hidden:= false
	var sprite_id = {
		'menu' : 0,
		'battle' : 0,
	}
	var cure_on_battle_end:= true
	var prevent_action:= false
	
	var stat_adder_function: Callable = func(base_stats: Stats.BaseStats) -> Stats.BaseStats: return base_stats
	var stat_multiplier_function: Callable = func(base_stats: Stats.BaseStats) -> Stats.BaseStats: return base_stats
	
	var count_down_on_turn:= true
	var effect_on_count_down: Callable = func(stats: Stats) -> Stats: return stats
	var effect_on_damage_taken: Callable = func(stats: Stats) -> Stats: return stats
	var effect_on_side_switch: Callable = func(stats: Stats) -> Stats: return stats
	var action_on_cure:= {
		"act": false,
		"skill_ID": 0,
		"target": "none",
	}

	var optional_properties:= {
		##guaranteed_crit: True,
		##taunt_target: unit_reference // who is the taunt victim forced to target
	}

	func _init(init_id: String, init_name: String):
		self.id = init_id
		self.name = init_name


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
	DICTIONARY.SE_1.stat_multiplier_function = func(base_stats: Stats.BaseStats) -> Stats.BaseStats:
		var res:= DeepCopy.copy_base_stats(base_stats)
		res.physical.attack *= 1.5
		res.magical.attack *= 1.5
		return res
	DICTIONARY.SE_1.stat_adder_function = func(base_stats: Stats.BaseStats) -> Stats.BaseStats:
		var res:= DeepCopy.copy_base_stats(base_stats)
		res.physical.defense += 20
		return res
	
	add_effect("SE_2", "stat_test_buff_2")
	DICTIONARY.SE_2.stat_adder_function = func(base_stats: Stats.BaseStats) -> Stats.BaseStats:
		var res:= DeepCopy.copy_base_stats(base_stats)
		res.magical.attack += 20
		return res

	# call_deferred("emit_signal", "initialized")
