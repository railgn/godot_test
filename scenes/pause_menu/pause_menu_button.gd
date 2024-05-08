class_name PauseMenuButton
extends Button

signal option_selected(button_text: String)

func _init(option:String):
	name = option
	text = option

func _ready():
	pressed.connect(_on_pressed)


func _on_pressed():
	option_selected.emit(self)

