class_name TargetController
extends Control

signal target_chosen(target: Intent.Target)
signal target_back()

var target: Intent.Target

func _init(init_target: Intent.Target):
	target = init_target

func _ready():
	add_to_group("target_controller")
	focus_mode = Control.FOCUS_ALL
	focus_entered.connect(_on_focus_entered)
	focus_exited.connect(_on_focus_exited)

func _on_focus_entered():
	for node_path in find_nodes_to_focus(target):
		var node: BattleUnit = get_node(node_path)
		node.focussed = true

func _on_focus_exited():
	for node_path in find_nodes_to_focus(target):
		var node: BattleUnit = get_node(node_path)
		node.focussed = false

func find_nodes_to_focus(target_local: Intent.Target) -> Array[NodePath]:
	var res: Array[NodePath] = []

	for node_path in target_local.node_paths:
		res.append(node_path)

	for node_path in target_local.additional_targets:
		res.append(node_path)

	return res

func _process(_delta):
	if has_focus() and Input.is_action_just_pressed("ui_accept"):
		target_chosen.emit(target, self)
	if has_focus() and Input.is_action_just_pressed("ui_cancel"):
		target_back.emit(self)
	