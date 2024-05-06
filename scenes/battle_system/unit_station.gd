extends Node2D

var child_count: int

func arrange_y(children: Array[Node]):
	# var screen_height:= 720
	var center:= 0
	var distance_between:= 150

	var first_y = -(((children.size() - 1.0) * distance_between)/2 + center)

	for child in children:

		child.transform.origin.y = roundi(first_y)

		first_y += distance_between
		pass


func _process(_delta):
	var current_child_count = get_child_count()

	if child_count != current_child_count:
		var children = get_children()
		arrange_y(children)
		child_count = current_child_count

