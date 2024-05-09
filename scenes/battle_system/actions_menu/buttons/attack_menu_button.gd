class_name AttackMenuButton
extends ActionsMenuButton

func _init():
	text = "Attack"

func _ready():
	pressed.connect(_on_pressed)
	focus_entered.connect(_on_focus_entered)
	
func _on_pressed():
	var action:= Intent.Action.new(Intent.Action.Type.BASIC_ATTACK, "SK_0")

	action_chosen.emit(action)

func _on_focus_entered():
	dialogue_change.emit("Basic Attack")