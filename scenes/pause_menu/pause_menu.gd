extends Node2D

var save_data_node_name = ["Party"]
var dictionaries = {}

var current_path_array: Array[String] = []

func _ready():
	await Party.initialized

	var root = get_tree().get_root()

	for node_name in save_data_node_name:
		dictionaries[node_name] = root.get_node(node_name).DICTIONARY

	build_menus(current_path_array)



func build_menus(path_array: Array[String]):
	var current_dict= follow_path(current_path_array)

	var menu_options= [] 
	
	if current_dict is Dictionary:
		menu_options = 	current_dict.keys()
	elif current_dict is Object:
		var properties = current_dict.get_property_list().slice(3)

		var res = []
		for prop in properties:
			res.append(prop.name)

		menu_options = res




	if path_array.size() > 0:
		menu_options.append("back")
	var y_offset:= 0
	var distance_between:= 25
	

	for option in menu_options:
		
		var button: PauseMenuButton
		if option == "back":
			button = PauseMenuButton.new(option)
		elif current_dict[option] is Object or current_dict[option] is Dictionary:
			button = PauseMenuButton.new(option)
		else:
			var text = option + " = " + str(current_dict[option])
			button = PauseMenuButton.new(text)
			button.disabled = true

		button.position.y = y_offset

		y_offset+= distance_between

		button.option_selected.connect(_on_option_selected)

		add_child(button)



func follow_path(path_arr: Array[String]):
	var res = dictionaries

	for path in path_arr:
		res = res[path]
	

	return res

func _on_option_selected(button: Button):

	if button.text == "back":
		current_path_array.pop_back()
	else:
		current_path_array.append(button.text)

	for n in get_children():
		remove_child(n)
		n.queue_free()

	build_menus(current_path_array)

