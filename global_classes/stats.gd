class_name Stats
# extends Resource

class MappingStats:
	var strength: int = 1
	var intelligence: int = 1
	var agility: int = 1
	var dexterity: int = 1
	var vitality: int = 1
	var wisdom: int = 1
	var luck: int = 1

class BaseStats:
	class StatResource:
		var current := 1.0
		var maximum := 1.0

	class DamageType:
		var attack := 1.0
		var defense := 1.0

	var hp := StatResource.new()
	var mp := StatResource.new()
	var energy := StatResource.new()
	var physical = DamageType.new()
	var magical = DamageType.new()
	var turn_speed := 1.0
	var healing_power := 1.0
	var hit_rate := 1.0
	var avoid := 1.0
	var critical_chance := 1.0
	var critical_avoid := 1.0
	var ailment_infliction_chance := 1.0

class StatusEffectStore:
	var id: String
	var turns_left: int
	var level: int
	var does_not_expire: bool
	var permanent_persists_outside_battle: bool

	func _init(init_id: String, 
			init_turns_left: int, 
			init_level:= 1, 
			init_does_not_expire:= false, 
			init_permanent_persists_outside_battle:= false):
		self.id = init_id
		self.turns_left = init_turns_left
		self.level = init_level
		self.does_not_expire = init_does_not_expire
		self.permanent_persists_outside_battle = init_permanent_persists_outside_battle

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
		var res_combat_stats = DeepCopy.copy_base_stats(self.base_stats)
		res_combat_stats = multiply_stats(add_stats(res_combat_stats, self.base_stats_adder), new_base_stats_multiplier)

		base_stats_multiplier = new_base_stats_multiplier
		self.combat_stats = res_combat_stats

var base_stats_adder := BaseStats.new():
	set(new_base_stats_adder):
		var res_combat_stats = DeepCopy.copy_base_stats(self.base_stats)
		res_combat_stats = multiply_stats(add_stats(res_combat_stats, new_base_stats_adder), self.base_stats_multiplier)

		base_stats_adder = new_base_stats_adder
		self.combat_stats = res_combat_stats



##need to type this dictionary's values as "StatusEffectStore"
##keep as setter vs. call manual (so only calls once at end of turn?)
var status_effects_store := {}:
	set(new_status_effects_store):
		var res_base_stats_adder := BaseStats.new()
		var res_base_stats_multiplier := BaseStats.new()
		var res_can_act := true

		for status_effect_id in new_status_effects_store:
			if new_status_effects_store[status_effect_id].turns_left <= 0:
				new_status_effects_store.erase(status_effect_id)
			else:
				var effect = StatusEffects.get_effect(status_effect_id)

				res_base_stats_adder = effect.stat_adder_function.call(
					res_base_stats_adder, 
					new_status_effects_store[status_effect_id].level,
					)
				res_base_stats_multiplier = effect.stat_multiplier_function.call(
					res_base_stats_multiplier, 
					new_status_effects_store[status_effect_id].level,
					)

				if effect.prevent_action:
					res_can_act = false

		status_effects_store = new_status_effects_store
		self.base_stats_multiplier = res_base_stats_multiplier
		self.base_stats_adder = res_base_stats_adder
		self.can_act = res_can_act

# used to calculate combat stats in multiplier setter
func multiply_stats(base: BaseStats, multiplier: BaseStats) -> BaseStats:
	var res := DeepCopy.copy_base_stats(base)

	res.hp.current *= multiplier.hp.current
	res.hp.maximum *= multiplier.hp.maximum
	res.mp.maximum *= multiplier.mp.maximum
	res.mp.current *= multiplier.mp.current
	res.energy.maximum *= multiplier.energy.maximum
	res.energy.current *= multiplier.energy.current
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

func add_stats(base: BaseStats, adder: BaseStats) -> BaseStats:
	var res := DeepCopy.copy_base_stats(base)

	res.hp.current += (adder.hp.current - 1)
	res.hp.maximum += (adder.hp.maximum -1)
	res.mp.maximum += (adder.mp.maximum -1)
	res.mp.current += (adder.mp.current -1)
	res.energy.maximum += (adder.energy.maximum -1)
	res.energy.current += (adder.energy.current -1)
	res.physical.attack += (adder.physical.attack -1)
	res.physical.defense += (adder.physical.defense -1)
	res.magical.attack += (adder.magical.attack -1)
	res.magical.defense += (adder.magical.defense -1)
	res.turn_speed += (adder.turn_speed -1)
	res.healing_power += (adder.healing_power -1)
	res.hit_rate += (adder.hit_rate -1)
	res.avoid += (adder.avoid -1)
	res.critical_chance += (adder.critical_chance -1)
	res.critical_avoid += (adder.critical_avoid -1)
	res.ailment_infliction_chance += (adder.ailment_infliction_chance -1)

	return res

#creates new copy of status effect dictionary for assignment to trigger setter
func add_status_effect(new_effect: StatusEffectStore):
	var res_status_effects = DeepCopy.copy_stats_status_effects(self.status_effects_store)
	res_status_effects[new_effect.id] = new_effect
	self.status_effects_store = res_status_effects
