extends Sprite2D

func _ready():
	var sprite: Texture2D

	sprite = load("res://assets/ui/pointer_icon.png")

	texture = sprite

	var unit_ui: Node = get_parent()

	unit_ui.parent_unit_init.connect(_on_parent_unit_init)

func _on_parent_unit_init(parent_unit: Node):
	parent_unit.finalized_as_target_change.connect(_on_finalized_as_target_change)



func _on_finalized_as_target_change(finalized_as_target: bool):
	if finalized_as_target:
		show()
	else:
		hide()


