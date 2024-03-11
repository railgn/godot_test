extends Node

func copy_base_stats(original: Stats.BaseStats) -> Stats.BaseStats:
	var res = Stats.BaseStats.new()

	res.hp.current = original.hp.current
	res.hp.maximum = original.hp.maximum
	res.mp.current = original.mp.current
	res.mp.maximum = original.mp.maximum
	res.physical.attack = original.physical.attack
	res.physical.defense = original.physical.defense
	res.magical.attack = original.magical.attack
	res.magical.defense = original.magical.defense
	res.turn_speed = original.turn_speed
	res.healing_power = original.healing_power
	res.hit_rate = original.hit_rate
	res.avoid = original.avoid
	res.critical_chance = original.critical_chance
	res.critical_avoid = original.critical_avoid
	res.ailment_infliction_chance = original.ailment_infliction_chance

	return res

func copy_status_effects(original: Dictionary):
	var res = {}

	for se_id in original:
		res[se_id] = Stats.StatusEffectStore.new()
		res[se_id].id = original[se_id].id
		res[se_id].turns_left = original[se_id].turns_left

	return res
