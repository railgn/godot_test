extends Node2D

var parent_unit: BattleUnit


func _ready():
	parent_unit = get_parent()

	parent_unit.finalized_as_target_change.connect(_on_finalized_as_target_change)
	parent_unit.cost_preview_change.connect(_on_cost_preview_change)
	parent_unit.combat_preview_change.connect(_on_combat_preview_change)

func _on_finalized_as_target_change(finalized_as_target: bool):
	if finalized_as_target:
		$TargetPointer.show()
	else:
		$TargetPointer.hide()

func _on_cost_preview_change(cost_preview):
	pass

func _on_combat_preview_change(combat_preview: CombatPreview):
	pass

func _process(_delta):
	if parent_unit.cost_preview_on:
		$CostPreview.show()
	else:
		$CostPreview.hide()	
	
	if parent_unit.combat_preview_on:
		$CombatPreview.show()
	else:
		$CombatPreview.hide()
