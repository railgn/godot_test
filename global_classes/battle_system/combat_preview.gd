class_name CombatPreview

class DamagePreview:
	var resource: ActiveSkill.SkillCostResource
	var damage_range: Array[int]
	var hit_chance: float
	var crit_chance: float

class StatusEffectPreview:
	var status_id: String
	var infliction_chance: float

var type: ActiveSkill.SkillType
var damage: Array[DamagePreview]
var status: Array[StatusEffectPreview]
var healing: int