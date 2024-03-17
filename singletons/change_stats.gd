extends Node

# used to calculate combat stats in multiplier setter
func multiply_base_stats(base: Stats.BaseStats, multiplier: Stats.BaseStats) -> Stats.BaseStats:
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

func add_base_stats(base: Stats.BaseStats, adder: Stats.BaseStats) -> Stats.BaseStats:
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

func update_combat_stats(base_stats:Stats.BaseStats, base_stats_adder:Stats.BaseStats, base_stats_multiplier:Stats.BaseStats) -> Stats.BaseStats:
	var res_combat_stats:= DeepCopy.copy_base_stats(base_stats)
	res_combat_stats = multiply_base_stats(add_base_stats(res_combat_stats, base_stats_adder), base_stats_multiplier)

	return res_combat_stats