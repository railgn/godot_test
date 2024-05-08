class_name ActionsMenu
extends Node2D

signal intent_chosen(intent: Intent)

var chosen_intent: Intent

var unit_stations
var mirror_cast_resource

func _init(init_unit_stations):
	unit_stations = init_unit_stations

func _ready():
	build_action_menus()

func build_action_menus():
	## any global resource should be an input (, mirror_cast_resource: int)
		## only used to check if a skill is usable
		## unit stations too?

	## connect to signal
	pass

func build_target_menus():
	## connect to signal
	pass

func _on_action_chosen(action: Intent.Action):
	chosen_intent.action = action
	build_target_menus()

func _on_target_chosen(target: Intent.Target):
	chosen_intent.target = target
	intent_chosen.emit(chosen_intent)

