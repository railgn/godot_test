class_name ProcessSkill

class ProcessMagnitude:
	var damage: int = 0
	var splash_damage: int = 0
	var healing: int = 0

class ProcessCost:
	var resource:= ActiveSkill.SkillCostResource.MP
	var amount: int = 0

static func process_skill(user: BattleUnit, intent: Intent, unit_stations: Node):
	var skill_info: ActiveSkill = Skills.get_skill(intent.action.id)

	var skill_cost:= calc_skill_cost(skill_info, user, intent)
	
	## consume resource
	match skill_cost.resource:
		ActiveSkill.SkillCostResource.MP:
			user.stats.combat_stats.mp.current -= skill_cost.amount
		ActiveSkill.SkillCostResource.HP:
			user.stats.combat_stats.hp.current -= skill_cost.amount
		ActiveSkill.SkillCostResource.ENERGY:
			user.stats.combat_stats.energy.current -= skill_cost.amount
		ActiveSkill.SkillCostResource.YOYO:
			##reduce status effect level
			##or just add it as a proper resource to Base_Stats class
			pass
		ActiveSkill.SkillCostResource.POWER_CHARGE:
			##reduce status effect level
			##or just add it as a proper resource to Base_Stats class
			pass

	var skill_magnitude:= calc_skill_magnitude(skill_info, user, intent)


	##awaits in here for skill effects
	match skill_info.type:
		ActiveSkill.SkillType.DAMAGE:
			if skill_info.active_optional_properties.has("guarantee_crit"):
				pass
			if skill_info.active_optional_properties.has("bonus_on_bleed"):
				pass



			# for target in targets
				# if target.check_for_death
					#if skill_info.active_optional_properties.has("on_kill"):

			pass
		ActiveSkill.SkillType.RECOVERY:


			if skill_info.active_optional_properties.has("revive"):
				#revive hp%
				pass
			pass
		ActiveSkill.SkillType.STATUS:
			pass
		ActiveSkill.SkillType.SPAWN:
			pass

	##play animation
	
	## some checks will be "if" checks within the above match
	for prop in skill_info.active_optional_properties:
		match prop:
			"status_effect_on_user":
				pass
			"status_effect_on_target":
				pass
			_:
				pass

static func calc_skill_cost(skill_info: ActiveSkill, user: BattleUnit, intent: Intent) -> ProcessCost:
	var res:= ProcessCost.new()
	## call off skill info

	return res

static func calc_skill_magnitude(skill_info: ActiveSkill, user: BattleUnit, intent: Intent) -> ProcessMagnitude:
	var res:= ProcessMagnitude.new()
	## call off skill info
	if skill_info.active_optional_properties.has("cost_refund_on_bleed"):
		pass

	return res
