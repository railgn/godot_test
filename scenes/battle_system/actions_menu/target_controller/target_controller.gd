class_name TargetController
extends Control

signal target_chosen(target: Intent.Target)
signal target_back()
signal last_control_focus(group: String, control: Control)

var target: Intent.Target

func _init(init_target: Intent.Target):
	target = init_target
	focus_mode = Control.FOCUS_ALL
	add_to_group("target_controller")
	focus_entered.connect(_on_focus_entered)
	focus_exited.connect(_on_focus_exited)

func _on_focus_entered():
	for target_store in find_nodes_to_focus(target):
		var node: BattleUnit = get_node(target_store.node_path)
		node.focussed = true
		node.combat_preview = target_store.combat_preview
		node.combat_preview_on = true
	last_control_focus.emit("Target", self)

func _on_focus_exited():
	for target_store in find_nodes_to_focus(target):
		var node: BattleUnit = get_node(target_store.node_path)
		node.focussed = false
		node.combat_preview_on = false

func find_nodes_to_focus(target_local: Intent.Target) -> Array[Intent.Target.TargetStore]:
	var res: Array[Intent.Target.TargetStore] = []

	for target_store in target_local.main_targets:
		res.append(target_store)

	for target_store in target_local.additional_targets:
		res.append(target_store)

	return res

func _process(_delta):
	if has_focus() and Input.is_action_just_pressed("ui_accept"):
		target_chosen.emit(target, self)
	if has_focus() and Input.is_action_just_pressed("ui_cancel"):
		target_back.emit(self)
	