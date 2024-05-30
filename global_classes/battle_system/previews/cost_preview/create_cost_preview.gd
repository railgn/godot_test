class_name CreateCostPreview

static func create_cost_preview(unit: BattlePlayerUnit, skill_info:ActiveSkill, level: int) -> Array[CostPreview]:
	var res : Array[CostPreview] = []

	var preview:= CostPreview.new()
	preview.resource = skill_info.cost.resource
	preview.amount = skill_info.cost.amount.call(level, skill_info.cost.resource, unit.stats)
	preview.usable = check_if_skill_usable(unit, skill_info, preview.amount)
	
	res.append(preview)

	## add additional costs here from active_skill_optional_properties
		##passives that cause half of mp costs to be an hp cost instead
			##blood magic


	return res


static func check_if_skill_usable(unit: BattlePlayerUnit, skill_info:ActiveSkill, cost_amount:int) -> bool:

	var usable:= true

	if skill_info.mirror:
		usable = unit.stats.mirror

	if usable:
		match skill_info.cost.resource:
			ActiveSkill.SkillCostResource.NONE:
				pass
			ActiveSkill.SkillCostResource.HP:
				if unit.stats.combat_stats.hp.current <= cost_amount:
					usable = false
			ActiveSkill.SkillCostResource.MP:
				if unit.stats.combat_stats.mp.current < cost_amount:
					usable = false
			ActiveSkill.SkillCostResource.ENERGY:
				if unit.stats.combat_stats.energy.current < cost_amount:
					usable = false
			ActiveSkill.SkillCostResource.YOYO:
				pass
			ActiveSkill.SkillCostResource.POWER_CHARGE:
				pass
		
		for prerequisite in skill_info.prerequisites:
			match prerequisite:
				ActiveSkill.PrerequisitesEnum.STATUS_EFFECT:
					if !unit.stats.status_effects_store.has(skill_info.prerequisites[prerequisite]):
						usable = false
				ActiveSkill.PrerequisitesEnum.SKILL:
					if (!unit.skills_store_player.active_skills.has(skill_info.prerequisites[prerequisite]) 
						and !unit.skills_store_player.passive_skills_skills.has(skill_info.prerequisites[prerequisite])):
						usable = false
				ActiveSkill.PrerequisitesEnum.YOYO:
					pass
				ActiveSkill.PrerequisitesEnum.POWER_CHARGE:
					pass

	return usable
