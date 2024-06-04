extends Node2D

var parent_unit: BattleUnit

func _ready():
	parent_unit = get_parent()

	parent_unit.finalized_as_target_change.connect(_on_finalized_as_target_change)
	parent_unit.cost_previews_change.connect(_on_cost_previews_change)
	parent_unit.combat_preview_change.connect(_on_combat_preview_change)

	$HealthBar.resource = ActiveSkill.SkillCostResource.HP
	$HealthBar.unit = parent_unit

	$MPBar.resource = ActiveSkill.SkillCostResource.MP
	$MPBar.unit = parent_unit

	$PreviewLabel.unit = parent_unit

func _on_finalized_as_target_change(finalized_as_target: bool):
	if finalized_as_target:
		$TargetPointer.show()
	else:
		$TargetPointer.hide()

func _on_cost_previews_change(cost_previews: Array[CostPreview]):
	$HealthBar.show_cost_preview = false
	$MPBar.show_cost_preview = false
	for cost_preview in cost_previews:
		match cost_preview.resource:
			ActiveSkill.SkillCostResource.HP:
				$HealthBar.update_cost_preview(cost_preview)
				$HealthBar.show_cost_preview = true
			ActiveSkill.SkillCostResource.MP:
				$MPBar.update_cost_preview(cost_preview)
				$MPBar.show_cost_preview = true

	$PreviewLabel.update_cost_previews(cost_previews)

func _on_combat_preview_change(combat_preview: CombatPreview):
	$HealthBar.show_combat_preview = false
	$MPBar.show_combat_preview = false
	if combat_preview:
		for damage in combat_preview.damage:
			match damage.resource:
				ActiveSkill.SkillCostResource.HP:
					$HealthBar.update_damage_preview(damage)
					$HealthBar.show_combat_preview = true
				ActiveSkill.SkillCostResource.MP:
					$MPBar.update_damage_preview(damage)
					$MPBar.show_combat_preview = true
		
		if combat_preview.healing:
			match combat_preview.healing.resource:
				ActiveSkill.SkillCostResource.HP:
					$HealthBar.update_healing_preview(combat_preview.healing.amount)
					$HealthBar.show_combat_preview = true
				ActiveSkill.SkillCostResource.MP:
					$MPBar.update_healing_preview(combat_preview.healing.amount)
					$MPBar.show_combat_preview = true

		$PreviewLabel.update_combat_preview(combat_preview)