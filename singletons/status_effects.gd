extends Node

var DICTIONARY:= {}

class StatusEffect:
	var id:= "SE_0"
	var name:= "default"
	var hidden:= false
	var sprite_id = {
		'menu' : 0,
		'battle' : 0,
	}
	var cure_on_battle_end:= true
	var prevent_action:= true
	var optional_properties:= {}
	var stat_multiplier_function: Callable = func(base_stats: Stats.BaseStats) -> Stats.BaseStats: return base_stats

	func _init(init_id: String, init_name: String):
		self.id = init_id
		self.name = init_name


func add_effect(init_id: String, init_name: String):
	DICTIONARY[init_id] = StatusEffect.new(init_id, init_name)

func get_effect(id: String) -> StatusEffect:
	return DICTIONARY[id]

# func edit_effect(id, property, value):

# signal initialized

func _ready():
	add_effect("SE_0", "default")

	add_effect("SE_1", "attack_buff")
	DICTIONARY.SE_1.stat_multiplier_function = func(base_stats: Stats.BaseStats) -> Stats.BaseStats:
		var res:= base_stats
		res.physical.attack *= 1.5
		return res


	# call_deferred("emit_signal", "initialized")
