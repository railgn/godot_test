class_name StatusEffect

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

var base_stat_adder_function: Callable = func(base_stats: Stats.BaseStats, _level) -> Stats.BaseStats: return base_stats
var base_stat_multiplier_function: Callable = func(base_stats: Stats.BaseStats, _level) -> Stats.BaseStats: return base_stats

var count_down_on_turn:= true
var effect_on_count_down: Callable = func(stats: Stats, _level) -> Stats: return stats
var effect_on_damage_taken: Callable = func(stats: Stats, _level) -> Stats: return stats
var effect_on_side_switch: Callable = func(stats: Stats, _level) -> Stats: return stats
## useful for passive skills that trigger an in battle status effect
var effect_on_battle_start: Callable = func(stats: Stats, _level) -> Stats: return stats

var action_on_cure:= {
    "act": false,
    "skill_ID": 0,
    "target": "none",
}

var optional_properties:= {
    ##guaranteed_crit: True,
    ##taunt_target: unit_reference // who is the taunt victim forced to target
    ##effect_on_turn_start: use action? store similar data to scripted enemy AI
}

func _init(init_id: String, init_name: String):
    self.id = init_id
    self.name = init_name