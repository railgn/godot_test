class_name CreateDamagePreview

static func create_damage_preview(user: BattleUnit, target: BattleUnit, skill_info: ActiveSkill, action: Intent.Action, is_main_target: bool) -> Array[CombatPreview.DamagePreview]:
	var res:= CombatPreview.DamagePreview.new()

	if skill_info.damage_type == ActiveSkill.DamageType.MP:
		res.resource = ActiveSkill.SkillCostResource.MP
	else:
		res.resource = ActiveSkill.SkillCostResource.HP

	res.damage_range = damage_calc(user, target, skill_info, action, is_main_target)	

	res.crit_chance = crit_rate_calc(user, target, skill_info)
	res.hit_chance = hit_rate_calc(user, target, skill_info)

	var final_res:Array[CombatPreview.DamagePreview]= [res]
	
	if skill_info.active_optional_properties.has("repeats"):
		for i in range(skill_info.active_optional_properties.repeats):
			final_res.append(res)

	return final_res

static func damage_calc(user: BattleUnit, target: BattleUnit, skill_info: ActiveSkill, action: Intent.Action, is_main_target: bool):
	var res: Array[int] = []

	var base_damage: float = 0

	if is_main_target:
		base_damage = skill_info.magnitude.damage.call(action.level, user.stats)
	else:
		base_damage = skill_info.magnitude.splash_damage.call(action.level, user.stats)

	var mult_damage = base_damage * damage_property_multiplier(user, target, skill_info)
	
	var base_defense: float = 0
	
	if !skill_info.active_optional_properties.has("ignore_defense"):
		match skill_info.damage_type:
			ActiveSkill.DamageType.PHYSICAL:
				base_defense = target.stats.combat_stats.physical.defense
			ActiveSkill.DamageType.MAGICAL:
				base_defense = target.stats.combat_stats.magical.defense
	
	var net_damage: float = mult_damage - base_defense

	if net_damage < 0:
		net_damage = 0

	var range_percent: float = 0.1
	
	res = [int(net_damage * (1 - range_percent)), int(net_damage * (1 + range_percent))]

	return res

static func damage_property_multiplier(_user, target, skill_info) -> float:
	var res_multiplier:= 1.0

	if skill_info.active_optional_properties.has("bonus_on_bleed"):
		if UnitConditionals.is_bleeding(target):
			res_multiplier *= skill_info.active_optional_properties.bonus_on_bleed
	
	## Just have charge buff double combat attack directly?
	##charge buffs? need to make sure they get reset after an attack
	# if user.stats.status_effects_store.has("SE_Charge"):
	# 	res_multiplier *= 2.0

	return res_multiplier

static func crit_rate_calc(user, target, skill_info) -> float:
	var res:= 0.0

	if skill_info.damage_type == ActiveSkill.DamageType.PHYSICAL or skill_info.active_optional_properties.has("can_crit"):
		res = user.stats.combat_stats.critical_chance - target.stats.combat_stats.critical_avoid

	if skill_info.active_optional_properties.has("cannot_crit"):
		res= 0.0

	if skill_info.active_optional_properties.has("guaranteed_crit"):
		res = 1.0

	return res

static func hit_rate_calc(user, target, skill_info) -> float:
	var res:= 1.0

	var accuracy_multiplier:= 1.0 

	if skill_info.active_optional_properties.has("accuracy_multiplier"):
		accuracy_multiplier = skill_info.active_optional_properties.accuracy_mult

	if skill_info.damage_type == ActiveSkill.DamageType.PHYSICAL or skill_info.active_optional_properties.has("can_crit"):
		res = 1 + user.stats.combat_stats.hit_rate * accuracy_multiplier - target.stats.combat_stats.avoid
	
	if skill_info.active_optional_properties.has("cannot_miss"):
		res = 1.0	

	return res
