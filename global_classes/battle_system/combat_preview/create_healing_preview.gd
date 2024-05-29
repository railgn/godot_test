class_name  CreateHealingPreview

static func create_healing_preview(user: BattleUnit, _target: BattleUnit, skill_info: ActiveSkill, action: Intent.Action, is_main_target: bool) -> int:
	var res: int = 0

	if is_main_target:
		res = skill_info.magnitude.damage.call(action.level, user.stats)
	else:
		res = skill_info.magnitude.splash_damage.call(action.level, user.stats)

	## status effect healing multipliers on target?
	## change healing to be a seperate function rather than just reusing the damage and splash damage functions?

	return int(res)