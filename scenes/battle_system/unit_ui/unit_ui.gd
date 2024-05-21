extends Node2D

signal parent_unit_init(parent_unit: Node2D)

func _ready():
	var parent_unit = get_parent()

	parent_unit_init.emit(parent_unit)
