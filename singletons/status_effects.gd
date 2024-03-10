extends Node

class StatusEffect:
	var id:= "SE_O"
	var hidden:= false
	var sprite_id = {
		'menu' : 0,
		'battle' : 0,
	}
	var cure_on_battle_end:= true
	var prevent_action:= true
	var optional_properties:= {}
	var stat_multiplier_function: Callable = func(base_stats: Stats.BaseStats) -> Stats.BaseStats: return base_stats

# signal initialized

## type values as StatusEffects
## ^ but what about optional properties?
var DICTIONARY := {}

func _ready():
	DICTIONARY.SE_0 = StatusEffect.new()

	DICTIONARY.SE_1 = StatusEffect.new()
	DICTIONARY.SE_1.id = "SE_1"
	DICTIONARY.SE_1.stat_multiplier_function = func(base_stats: Stats.BaseStats) -> Stats.BaseStats:
		var res:= base_stats
		res.physical.attack *= 1.5
		return res


	# call_deferred("emit_signal", "initialized")
