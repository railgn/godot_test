class_name CreateCombatPreview

class ProcessMagnitude:
	var damage: int = 0
	var splash_damage: int = 0
	var healing: int = 0

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
	var res: CombatPreview

	var skill_info: ActiveSkill = Skills.get_skill(action.id)
	var magnitude: ProcessMagnitude = calc_skill_magnitude(skill_info, user, action)

	match skill_info.type:
		ActiveSkill.SkillType.DAMAGE:

			# for target in targets
				#calc damage
				#apply damage


				# if target.check_for_death()
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

	for prop in skill_info.active_optional_properties:
		match prop:
			"status_effect_on_target":
				pass
			_:
				pass




	return res



static func calc_skill_magnitude(skill_info: ActiveSkill, user: BattleUnit, action: Intent.Action) -> ProcessMagnitude:
	var res:= ProcessMagnitude.new()

	res.damage = skill_info.magnitude.damage.call(action.level, user.stats)
	res.splash_damage = skill_info.magnitude.splash_damage.call(action.level, user.stats)
	res.healing = skill_info.magnitude.healing.call(action.level, user.stats)

	return res

static func calc_damage(user: BattleUnit, target: BattleUnit, skill_magnitude: ProcessMagnitude, skill_info: ActiveSkill) -> CombatPreview.DamagePreview:
	var res:= CombatPreview.DamagePreview.new()

	##damage type
		##optional property checks for ignoring def/res

	##crit chance

	##hit chance
	var hit_chance:= 1 + user.stats.combat_stats.hit_rate - target.stats.combat_stats.avoid

	return res

