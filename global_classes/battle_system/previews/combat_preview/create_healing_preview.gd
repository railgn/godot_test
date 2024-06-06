class_name  CreateHealingPreview

static func create_healing_preview(user: BattleUnit, _target: BattleUnit, skill_info: ActiveSkill, action: Intent.Action, is_main_target: bool) -> Array[CombatPreview.HealingPreview]:
	var res:= CombatPreview.HealingPreview.new()

	if is_main_target:
		res.amount = skill_info.magnitude.damage.call(action.level, user.stats)
	else:
		res.amount = skill_info.magnitude.splash_damage.call(action.level, user.stats)

	res.resource = ActiveSkill.SkillCostResource.HP

	## status effect healing multipliers on target?
	## change healing to be a seperate function rather than just reusing the damage and splash damage functions?
	## change resource to mana or others based on skill_info

	var final_res:Array[CombatPreview.HealingPreview]= [res]

	return final_res