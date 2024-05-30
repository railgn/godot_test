class_name BackMenuButton
extends ActionsMenuButton

var unit:BattleUnit

func _init(init_unit: BattleUnit):
	unit = init_unit

func _ready():
	add_to_group("actions_menu_button")
	text = "Back"
	focus_entered.connect(_on_focus_entered)

func _on_focus_entered():
	dialogue_change.emit("")
	unit.cost_previews_on = false

func _process(_delta):
	if visible and  Input.is_action_just_pressed("ui_cancel"):
		dialogue_change.emit("")
		pressed.emit()
