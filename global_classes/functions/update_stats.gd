class_name UpdateStats	
extends Node

var DEEP_COPY = DeepCopy.new()

# used to calculate combat stats in multiplier setter
func multiply_base_stats(base: Stats.BaseStats, multiplier: Stats.BaseStats) -> Stats.BaseStats:
	var res := DEEP_COPY.copy_base_stats(base)

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

func add_base_stats(base: Stats.BaseStats, adder: Stats.BaseStats) -> Stats.BaseStats:
	var res := DEEP_COPY.copy_base_stats(base)

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

func multiply_mapping_stats(base: Stats.MappingStats, multiplier: Stats.MappingStats) -> Stats.MappingStats:
	var res:= DEEP_COPY.copy_mapping_stats(base)

	res.strength *= multiplier.strength
	res.intelligence *= multiplier.intelligence
	res.agility *= multiplier.agility
	res.dexterity *= multiplier.dexterity
	res.vitality *= multiplier.vitality
	res.wisdom *= multiplier.wisdom
	res.luck *= multiplier.luck

	return res

func add_mapping_stats(base: Stats.MappingStats, adder: Stats.MappingStats) -> Stats.MappingStats:
	var res:= DEEP_COPY.copy_mapping_stats(base)

	res.strength += adder.strength - 1
	res.intelligence += adder.intelligence - 1
	res.agility += adder.agility - 1
	res.dexterity += adder.dexterity - 1
	res.vitality += adder.vitality - 1
	res.wisdom += adder.wisdom - 1
	res.luck += adder.luck - 1

	return res

func update_combat_stats(base_stats:Stats.BaseStats, base_stats_adder:Stats.BaseStats, base_stats_multiplier:Stats.BaseStats) -> Stats.BaseStats:
	var res_combat_stats:= DEEP_COPY.copy_base_stats(base_stats)
	res_combat_stats = multiply_base_stats(add_base_stats(res_combat_stats, base_stats_adder), base_stats_multiplier)

	return res_combat_stats

func recalc_base_stats(mapping_stats: Stats.MappingStats, equipment_bases: Stats.BaseStats) -> Stats.BaseStats:
	var res_base_stats:= Stats.BaseStats.new()
	##strength
	res_base_stats.physical.attack = mapping_stats.strength + equipment_bases.physical.attack - 1
	##intelligence
	res_base_stats.magical.attack = mapping_stats.intelligence + equipment_bases.magical.attack - 1
	##agility
	res_base_stats.turn_speed = mapping_stats.agility + equipment_bases.turn_speed - 1
	##dexterity
	res_base_stats.hit_rate = 1 + mapping_stats.dexterity*.02 + equipment_bases.hit_rate - 1
	##vitality
	res_base_stats.hp.maximum = mapping_stats.vitality + equipment_bases.hp.maximum - 1
	res_base_stats.physical.defense = mapping_stats.vitality + equipment_bases.physical.defense - 1
	##wisdom
	res_base_stats.magical.defense = mapping_stats.wisdom + equipment_bases.magical.defense - 1
	res_base_stats.healing_power = mapping_stats.wisdom + equipment_bases.healing_power - 1
	##luck
	res_base_stats.critical_avoid = 1 + mapping_stats.luck*.01 + equipment_bases.critical_avoid - 1
	res_base_stats.ailment_infliction_chance = 1 + mapping_stats.luck*.02 + equipment_bases.ailment_infliction_chance - 1
	##agi + luck
	res_base_stats.avoid = 1 + mapping_stats.agility*.02 + mapping_stats.luck*.01 + equipment_bases.avoid - 1
	##dex + luck
	res_base_stats.critical_chance = 1 + mapping_stats.dexterity*.02 + mapping_stats.luck*.01 + equipment_bases.critical_chance - 1
	##int + wis
	res_base_stats.mp.maximum = (mapping_stats.intelligence + mapping_stats.wisdom) + equipment_bases.mp.maximum - 1
	
	return res_base_stats

func recalc_equipment_bases(equipment_slots: Array[CharacterClass.Equipment_Slot]) -> Stats.BaseStats:
	var res = Stats.BaseStats.new()

	## Apply Equipment base stats
	# for each equip slot
	# check if equipmentID is not null
	# get info from dictionary
	# add


	return res