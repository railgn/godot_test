class_name BackMenuButton
extends ActionsMenuButton


func _ready():
	add_to_group("actions_menu_button")
	text = "Back"
	focus_entered.connect(_on_focus_entered)


func _on_focus_entered():
	dialogue_change.emit("")

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		dialogue_change.emit("")
		pressed.emit()
