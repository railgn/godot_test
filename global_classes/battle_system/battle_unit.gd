class_name BattleUnit
extends Node2D

signal units_turn_change(turn_order_index: int, new_units_turn: bool)
signal unit_focussed_change(turn_order_index: int, new_focussed: bool)
signal finalized_as_target_change(new_finalized_as_target: bool)
signal unit_died(unit: BattleUnit)

var turn_order_index: int
var turn_initialized: int

var level: int
var stats: Stats
var intent: Intent

var units_turn := false:
	set(new_units_turn):
		units_turn_change.emit(turn_order_index, new_units_turn)
		units_turn = new_units_turn
var focussed := false:
	set(new_focussed):
		unit_focussed_change.emit(turn_order_index, new_focussed)

		if new_focussed == true:
			modulate = Color.RED
		else:
			modulate = Color.WHITE
		
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







