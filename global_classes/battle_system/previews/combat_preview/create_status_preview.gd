class_name CreateStatusPreview

static func create_status_preview(user: BattleUnit, target: BattleUnit, skill_info: ActiveSkill, action: Intent.Action) -> Array[CombatPreview.StatusEffectPreview]:
	var res : Array[CombatPreview.StatusEffectPreview] = []

	if skill_info.active_optional_properties.has("status_on_target"):
		for status in skill_info.active_optional_properties["status_on_target"]:
			var se : ActiveSkill.ActiveSkillStatusEffectStore = skill_info.active_optional_properties["status_on_target"][status]
			var se_preview = CombatPreview.StatusEffectPreview.new()

			se_preview.status_id = se.id
			se_preview.duration = se.duration

			se_preview.infliction_chance = infliction_rate_calc(user.stats.combat_stats, target.stats.combat_stats, se.base_infliction_func, skill_info, action.level)

			res.append(se_preview)

	return res


static func infliction_rate_calc(user_stats: Stats.BaseStats, target_stats: Stats.BaseStats, base_infliction_func: Callable, _skill_info: ActiveSkill, level: int) -> float:
	var res:= 0.0

	var base_infliction_chance: float = base_infliction_func.call(level)

	res = base_infliction_chance + user_stats.ailment_infliction_chance - target_stats.ailment_avoid

	return res