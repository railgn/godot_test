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

	$StatusPreviewLabel.unit = parent_unit

	$StatusEffectLabel.unit = parent_unit

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

func _on_combat_preview_change(combat_preview: CombatPreview):
	$HealthBar.show_combat_preview = false
	$MPBar.show_combat_preview = false
	if combat_preview:
		for damage in combat_preview.damage:
			
			var resource_bar_node: ResourceBar
			match damage.resource:
				ActiveSkill.SkillCostResource.HP:
					resource_bar_node = $HealthBar
				ActiveSkill.SkillCostResource.MP:
					resource_bar_node = $MPBar

			resource_bar_node.update_damage_preview(damage)
			resource_bar_node.show_combat_preview = true
		
		for healing in combat_preview.healing:
			var resource_bar_node: ResourceBar
			match healing.resource:
				ActiveSkill.SkillCostResource.HP:
					resource_bar_node = $HealthBar
				ActiveSkill.SkillCostResource.MP:
					resource_bar_node = $MPBar

			resource_bar_node.update_healing_preview(healing)
			resource_bar_node.show_combat_preview = true

		$StatusPreviewLabel.update_combat_preview(combat_preview)
