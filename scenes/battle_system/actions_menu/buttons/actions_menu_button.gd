class_name ActionsMenuButton
extends Button

signal action_chosen(action: Intent.Action)
signal dialogue_change(dialogue: String)

func _ready():
	add_to_group("actions_menu_button")