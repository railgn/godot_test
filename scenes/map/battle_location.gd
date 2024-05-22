class_name BattleLocation
extends Button

signal location_chosen
@export var location_type:= Location.LocationType.BATTLE

func _ready():
	set_focus_mode(Control.FOCUS_ALL)
	pressed.connect(_on_pressed)

func _on_pressed():
	location_chosen.emit(location_type)