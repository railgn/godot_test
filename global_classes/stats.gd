class_name Stats
# extends Resource

##setters on these to change base stats?
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
var mapping_stats := MappingStats.new():
	set(new_mapping_stats):
		##strength
		base_stats.physical.attack = new_mapping_stats.strength
		##intelligence
		base_stats.magical.attack = new_mapping_stats.intelligence
		##agility
		base_stats.turn_speed = new_mapping_stats.agility
		##dexterity
		base_stats.hit_rate = 1 + new_mapping_stats.dexterity*.02
		##vitality
		base_stats.hp.maximum = new_mapping_stats.vitality
		base_stats.physical.defense = new_mapping_stats.vitality
		##wisdom
		base_stats.magical.defense = new_mapping_stats.wisdom
		base_stats.healing_power = new_mapping_stats.wisdom
		##luck
		base_stats.critical_avoid = 1 + new_mapping_stats.luck*.01
		base_stats.ailment_infliction_chance = 1 + new_mapping_stats.luck*.02
		##agi + luck
		base_stats.avoid = 1 + new_mapping_stats.agility*.02 + new_mapping_stats.luck*.01
		##dex + luck
		base_stats.critical_chance = 1 + new_mapping_stats.dexterity*.02 + new_mapping_stats.luck*.01
		##int + wis
		base_stats.mp.maximum = (new_mapping_stats.intelligence + new_mapping_stats.wisdom)
		
		mapping_stats = new_mapping_stats
var base_stats := BaseStats.new()
## add setter for this that builds combat stats
##abstract the combat stats builder used in base_stat_multiplier and adder?
var combat_stats := BaseStats.new()

var base_stats_multiplier := BaseStats.new():
	set(new_base_stats_multiplier):
		var res_combat_stats = DeepCopy.copy_base_stats(base_stats)
		res_combat_stats = ChangeStats.multiply_base_stats(ChangeStats.add_base_stats(res_combat_stats, base_stats_adder), new_base_stats_multiplier)

		base_stats_multiplier = new_base_stats_multiplier
		combat_stats = res_combat_stats

var base_stats_adder := BaseStats.new():
	set(new_base_stats_adder):
		var res_combat_stats = DeepCopy.copy_base_stats(base_stats)
		res_combat_stats = ChangeStats.multiply_base_stats(ChangeStats.add_base_stats(res_combat_stats, new_base_stats_adder), base_stats_multiplier)

		base_stats_adder = new_base_stats_adder
		combat_stats = res_combat_stats



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

				res_base_stats_adder = effect.base_stat_adder_function.call(
					res_base_stats_adder, 
					new_status_effects_store[status_effect_id].level,
					)
				res_base_stats_multiplier = effect.base_stat_multiplier_function.call(
					res_base_stats_multiplier, 
					new_status_effects_store[status_effect_id].level,
					)

				if effect.prevent_action:
					res_can_act = false

		status_effects_store = new_status_effects_store
		self.base_stats_multiplier = res_base_stats_multiplier
		self.base_stats_adder = res_base_stats_adder
		self.can_act = res_can_act

#creates new copy of status effect dictionary for assignment to trigger setter
func add_status_effect(new_effect: Stats.StatusEffectStore):
	var res_status_effects = DeepCopy.copy_stats_status_effects(self.status_effects_store)
	res_status_effects[new_effect.id] = new_effect
	self.status_effects_store = res_status_effects