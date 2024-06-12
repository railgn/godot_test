extends Node

var battle_system: Node
@export var original_scale:= Vector2(.1,.1)
@export var units_turn_scale:= Vector2(1.7,1.7)
@export var x_offset = 0
@export var distance_between = 80

func _ready():
	battle_system = get_parent()

	battle_system.turn_order_change.connect(_on_turn_order_change)

func _on_turn_order_change(units_in_turn_order: Array[BattleUnit]):

	for child in get_children():
		remove_child(child)
		child.queue_free()

	x_offset = 0

	for unit in units_in_turn_order:
		unit.unit_focussed_change.connect(_on_unit_focussed_change)
		unit.units_turn_change.connect(_on_units_turn_change)

		var unit_sprite: Sprite2D = unit.get_node("Sprite")
		var turn_sprite = Sprite2D.new()
		turn_sprite.texture = unit_sprite.texture
		turn_sprite.transform.origin = Vector2(x_offset, 0)

		if !unit.stats.ally:
			turn_sprite.flip_h = true
		turn_sprite.apply_scale(original_scale)


		add_child(turn_sprite)
		x_offset += distance_between

func _on_unit_focussed_change(turn_order_index: int, focussed: bool):
	var turn_sprite: Sprite2D = get_child(turn_order_index)

	if focussed:
		turn_sprite.modulate = Color.RED
	else:
		turn_sprite.modulate = Color.WHITE


func _on_units_turn_change(turn_order_index: int, units_turn: bool):
	var turn_sprite: Sprite2D = get_child(turn_order_index)

	if units_turn:
		turn_sprite.apply_scale(units_turn_scale)
	else:
		turn_sprite.apply_scale(Vector2.ONE/units_turn_scale)
	


