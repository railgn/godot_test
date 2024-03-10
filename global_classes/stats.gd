class_name Stats

class MappingStats:
    var strength: int = 1
    var intelligence: int = 1
    var agility: int = 1
    var dexterity: int = 1
    var vitality: int = 1
    var wisdom: int = 1
    var luck: int = 1

class BaseStats:
    class Stat_Resource:
        var current:= 1.0
        var maximum:= 1.0
    
    class Damage_Type:
        var attack:= 1.0
        var defense:= 1.0

    var hp:= Stat_Resource.new()
    var mp:= Stat_Resource.new()
    var physical = Damage_Type.new()
    var magical = Damage_Type.new()
    var turn_speed:= 1.0
    var healing_power:= 1.0
    var hit_rate:= 1.0
    var avoid:= 1.0
    var critical_chance:= 1.0
    var critical_avoid:= 1.0
    var ailment_infliction_chance:= 1.0

class Status_Effect_Store:
    var id: String
    var turns_left: int

var alive := true
var player := true
var ally := true
var mirror := false
var can_act := true
var mapping_stats := MappingStats.new()
var base_stats := BaseStats.new()
var combat_stats := BaseStats.new()

var base_stats_multiplier := BaseStats.new():
    set(new_base_stats_multiplier):
        var res_combat_stats = self.base_stats
        res_combat_stats = multiply_stats(res_combat_stats, new_base_stats_multiplier)

        base_stats_multiplier = new_base_stats_multiplier
        self.combat_stats = res_combat_stats

##need to type this dictionary's values as "Status_Effect_Store"
##keep as setter vs. call manual (so only calls once at end of turn?)
var status_effects := {}:
    set(new_status_effects):
        var res_base_stats_multiplier := BaseStats.new()
        var res_can_act := true

        for status_effect_id in new_status_effects:
            if new_status_effects[status_effect_id].turns_left <= 0:
                new_status_effects.erase(status_effect_id)
            else:
                print(status_effect_id)
                res_base_stats_multiplier = StatusEffects.DICTIONARY[status_effect_id].stat_multiplier_function.call(res_base_stats_multiplier)

                if StatusEffects.DICTIONARY[status_effect_id].prevent_action:
                    res_can_act = false

        status_effects = new_status_effects
        self.base_stats_multiplier = res_base_stats_multiplier
        self.can_act = res_can_act

# used to calculate combat stats in multiplier setter
func multiply_stats(base:BaseStats, multiplier:BaseStats) -> BaseStats:
    var res:= base
    
    res.hp.current *= multiplier.hp.current
    res.hp.maximum *= multiplier.hp.maximum
    res.mp.maximum *= multiplier.mp.maximum
    res.mp.current *= multiplier.mp.current
    res.physical.attack *= multiplier.physical.attack
    res.physical.defense *= multiplier.physical.defense
    res.magical.attack *= multiplier.magical.attack
    res.magical.defense *= multiplier.magical.defense
    res.turn_speed *= multiplier.turn_speed
    res.healing_power *= multiplier.healing_power
    res.hit_rate *= multiplier.hit_rate
    res.avoid *= multiplier.avoid
    res.critical_chance *= multiplier.critical_chance
    res.critical_avoid *= multiplier.critical_avoid
    res.ailment_infliction_chance *= multiplier.ailment_infliction_chance

    return res

#creates new copy of status effect dictionary for assignment to trigger setter
func add_status_effect(new_effect: Status_Effect_Store):
    var res_status_effects = self.status_effects 
    res_status_effects[new_effect.id] = new_effect
    self.status_effects = res_status_effects