class_name AttackMenuButton
extends ActionsMenuButton

func _init():
	text = "Attack"

func _ready():
	add_to_group("actions_menu_button")
	pressed.connect(_on_pressed)
	focus_entered.connect(_on_focus_entered)
	
func _on_pressed():
	var action:= Intent.Action.new(Intent.Action.Type.BASIC_ATTACK, "SK_0", 1, Intent.Action.CostPreview.new())

	action_chosen.emit(action)

func _on_focus_entered():
	dialogue_change.emit("Basic Attack")
	last_control_focus.emit("Action", self)
