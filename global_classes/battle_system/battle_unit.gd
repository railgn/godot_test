class_name BattleUnit
extends Node2D

signal units_turn_change(turn_order_index: int, new_units_turn: bool)
signal unit_focussed_change(turn_order_index: int, new_focussed: bool)
signal finalized_as_target_change(new_finalized_as_target: bool)
signal unit_died(unit: BattleUnit)
signal cost_previews_change(cost_previews: Array[CostPreview])
signal combat_preview_change(combat_preview: CombatPreview)

var turn_order_index: int
var turn_initialized: int

var level: int
var stats: Stats
var intent: Intent

var cost_previews: Array[CostPreview]:
	set(new_cost_preview):
		cost_previews_change.emit(new_cost_preview)
		cost_previews = new_cost_preview
var cost_previews_on:= false
var combat_preview: CombatPreview:
	set(new_combat_preview):
		combat_preview_change.emit(new_combat_preview)
		combat_preview = new_combat_preview
var combat_preview_on:= false

var units_turn := false:
	set(new_units_turn):
		units_turn_change.emit(turn_order_index, new_units_turn)
		units_turn = new_units_turn
var focussed := false:
	set(new_focussed):
		unit_focussed_change.emit(turn_order_index, new_focussed)

		if new_focussed == true:
			$Sprite.modulate = Color.RED
		else:
			$Sprite.modulate = Color.WHITE
		
		focussed = new_focussed
var finalized_as_target:= false:
	set(new_finalized_as_target):
		finalized_as_target_change.emit(new_finalized_as_target)
		finalized_as_target = new_finalized_as_target

func check_for_death() -> bool:
	var res = false
	
	if stats.combat_stats.hp.current <= 0:
		unit_died.emit(self)
		res = true
	
	##battle system will handle queue free
	## this should handle:
		## death animations
		## deaths door?
	## need to await this function if so

	return res

func affect_resource(reduce: bool, resource_type: ActiveSkill.SkillCostResource, amount: int):
	var applied_amount = amount
	
	if !reduce:
		applied_amount = -applied_amount

	


	match resource_type:
		ActiveSkill.SkillCostResource.MP:
			stats.combat_stats.mp.current -= amount
		ActiveSkill.SkillCostResource.HP:
			stats.combat_stats.hp.current -= amount
		ActiveSkill.SkillCostResource.ENERGY:
			stats.combat_stats.energy.current -= amount
		ActiveSkill.SkillCostResource.YOYO:
			##reduce status effect level
			##or just add it as a proper resource to Base_Stats class
			pass
		ActiveSkill.SkillCostResource.POWER_CHARGE:
			##reduce status effect level
			##or just add it as a proper resource to Base_Stats class
			pass