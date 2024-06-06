class_name CombatPreview

class DamagePreview:
	var resource: ActiveSkill.SkillCostResource
	var damage_range: Array[int] = [0]
	var hit_chance: float = 0
	var crit_chance: float = 0
	var repeats: int = 0

class StatusEffectPreview:
	var status_id: String
	var infliction_chance: float
	var duration: int

class HealingPreview:
	var resource: ActiveSkill.SkillCostResource
	var amount: int
	
var type: ActiveSkill.SkillType
var damage: Array[DamagePreview]
var status: Array[StatusEffectPreview]
var healing: Array[HealingPreview]