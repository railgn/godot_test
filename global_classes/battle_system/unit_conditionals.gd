class_name UnitConditionals

static func is_bleeding(unit: BattleUnit) -> bool:
	var res = false

	for effect in unit.stats.status_effects_store:
		var effect_info = StatusEffects.get_effect(unit.stats.status_effects_store[effect].id)
		if effect_info.optional_properties.has("bleed"):
			res = true

	return res