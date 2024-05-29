class_name CreateCombatPreview

static func create_combat_preview(user: BattleUnit, target: BattleUnit, action: Intent.Action, is_main_target: bool) -> CombatPreview:
	var res: CombatPreview

	match action.type:
		Intent.Action.Type.BASIC_ATTACK:
			pass
		Intent.Action.Type.DEFEND:
			pass
		Intent.Action.Type.SKILL:
			res = create_skill_preview(user, target, action, is_main_target)
		Intent.Action.Type.MIRROR_CAST:
			pass
		Intent.Action.Type.ITEM:
			pass
		
	return res

static func create_skill_preview(user: BattleUnit, target: BattleUnit, action: Intent.Action, is_main_target: bool) -> CombatPreview:
	var res:= CombatPreview.new()

	var skill_info: ActiveSkill = Skills.get_skill(action.id)

	res.type = skill_info.type

	match skill_info.type:
		ActiveSkill.SkillType.DAMAGE:
			res.damage = CreateDamagePreview.create_damage_preview(user, target, skill_info, action, is_main_target)
		ActiveSkill.SkillType.RECOVERY:
			res.healing = CreateHealingPreview.create_healing_preview(user, target, skill_info, action, is_main_target)
			pass
		ActiveSkill.SkillType.STATUS:
			pass
		ActiveSkill.SkillType.SPAWN:
			pass

	res.status = CreateStatusPreview.create_status_preview(user, target, skill_info, action)


	return res

