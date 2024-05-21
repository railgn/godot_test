class_name ActionsMenuButton
extends Button

signal action_chosen(action: Intent.Action)
signal dialogue_change(dialogue: String)
signal last_control_focus(group: String, control: Control)

func _ready():
	add_to_group("actions_menu_button")
