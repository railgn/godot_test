class_name DefendMenuButton
extends ActionsMenuButton

func _init():
	text = "Defend"

func _ready():
	add_to_group("actions_menu_button")
	pressed.connect(_on_pressed)
	focus_entered.connect(_on_focus_entered)
	
func _on_pressed():
	var action:= Intent.Action.new(Intent.Action.Type.DEFEND, "SK_100", 1)

	action_chosen.emit(action)

func _on_focus_entered():
	dialogue_change.emit("Defend")
	last_control_focus.emit("Action", self)