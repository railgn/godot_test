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
	class StatResource:
		var current := 1.0:
			set(new_current):
				if new_current > maximum:
					new_current = maximum

				if new_current < 0:
					new_current = 0

				current = new_current
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
	var optional_node_store: Array[BattleUnit]

	func _init(init_id: String, 
			init_turns_left: int, 
			init_level:= 1, 
			init_does_not_expire:= false, 
			init_permanent_persists_outside_battle:= false,
			init_optional_node_store: Array[BattleUnit] = []):
		self.id = init_id
		self.turns_left = init_turns_left
		self.level = init_level
		self.does_not_expire = init_does_not_expire
		self.permanent_persists_outside_battle = init_permanent_persists_outside_battle
		self.optional_node_store = init_optional_node_store
var alive := true
var player := true
var ally := true
var mirror := false
var can_act := true
var mapping_stats := MappingStats.new():
	set(new_mapping_stats):
		var res_base_stats = UpdateStats.recalc_base_stats(new_mapping_stats, equipment_bases)
		
		base_stats = res_base_stats
		mapping_stats = new_mapping_stats
var equipment_bases := BaseStats.new():
	set(new_equipment_bases):
		var res_base_stats = UpdateStats.recalc_base_stats(mapping_stats, new_equipment_bases)
		
		base_stats = res_base_stats
		equipment_bases = new_equipment_bases
var base_stats := BaseStats.new():
	set(new_base_stats):
		combat_stats = UpdateStats.update_combat_stats(new_base_stats, base_stats_adder, base_stats_multiplier, combat_stats)
		base_stats = new_base_stats
var combat_stats := BaseStats.new()

var base_stats_multiplier := BaseStats.new():
	set(new_base_stats_multiplier):
		combat_stats = UpdateStats.update_combat_stats(base_stats, base_stats_adder, new_base_stats_multiplier, combat_stats)
		base_stats_multiplier = new_base_stats_multiplier

var base_stats_adder := BaseStats.new():
	set(new_base_stats_adder):
		combat_stats = UpdateStats.update_combat_stats(base_stats,new_base_stats_adder,base_stats_multiplier, combat_stats)
		base_stats_adder = new_base_stats_adder

##only added/deleted from using add and delete functions below
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

func add_status_effect(new_effect: Stats.StatusEffectStore):
	var res_status_effects = DeepCopy.copy_stats_status_effects(self.status_effects_store)
	res_status_effects[new_effect.id] = new_effect

	self.status_effects_store = res_status_effects

func delete_status_effect(id_to_delete: String):
	var res_status_effects = DeepCopy.copy_stats_status_effects(self.status_effects_store)
	if res_status_effects.has(id_to_delete):
		res_status_effects.erase(id_to_delete)
	else:
		print("DELETING STATUS EFFECT DOES NOT EXITS: ", id_to_delete)

	self.status_effects_store = res_status_effects

