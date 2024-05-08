class_name BattleUnit
extends Node

signal unit_focussed_change
signal units_turn_change

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
		focussed = new_focussed

