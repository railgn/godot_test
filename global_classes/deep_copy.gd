class_name DeepCopy
extends Node

func copy_base_stats(original: Stats.BaseStats) -> Stats.BaseStats:
	var res = Stats.BaseStats.new()

	res.hp.current = original.hp.current
	res.hp.maximum = original.hp.maximum
	res.mp.current = original.mp.current
	res.mp.maximum = original.mp.maximum
	res.energy.current = original.energy.current
	res.energy.maximum = original.energy.maximum
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

func copy_mapping_stats(original: Stats.MappingStats) -> Stats.MappingStats:
	var res = Stats.MappingStats.new()

	res.strength = original.strength
	res.intelligence = original.intelligence
	res.agility = original.agility
	res.dexterity = original.dexterity
	res.vitality = original.vitality
	res.wisdom = original.wisdom
	res.luck = original.luck

	return res

func copy_stats_status_effects(original: Dictionary):
	var res = {}

	for se_id in original:
		res[se_id] = Stats.StatusEffectStore.new(original[se_id].id,
			original[se_id].turns_left,
			original[se_id].level,
			original[se_id].does_not_expire,
			original[se_id].permanent_persists_outside_battle)

	return res

func copy_skills_store(original: PartyMember.SkillsStore) -> PartyMember.SkillsStore:
	var res:= PartyMember.SkillsStore.new()

	for skill_id in original.active_skills:
		res.add_skill(true, skill_id, original.active_skills[skill_id].level)

	for skill_id in original.passive_skills:
		res.add_skill(false, skill_id, original.passive_skills[skill_id].level)
	
	return res
