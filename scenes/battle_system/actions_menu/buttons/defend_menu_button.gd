class_name DefendMenuButton
extends ActionsMenuButton

func _init():
	text = "Defend"

func _ready():
	pressed.connect(_on_pressed)
	focus_entered.connect(_on_focus_entered)
	
func _on_pressed():
	var action:= Intent.Action.new(Intent.Action.Type.DEFEND, "SK_100")

	action_chosen.emit(action)

func _on_focus_entered():
	dialogue_change.emit("Defend")