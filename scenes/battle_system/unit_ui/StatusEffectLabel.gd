extends RichTextLabel

var unit: BattleUnit

func _init():
	fit_content = true
	scroll_active = false
	bbcode_enabled = true
	add_theme_font_size_override("normal_font_size", 15)

func create_text_label() -> String:
	var res_text = ""

	for status in unit.stats.status_effects_store:
		var status_info = StatusEffects.get_effect(unit.stats.status_effects_store[status].id)
		res_text += status_info.name + " - " + str(unit.stats.status_effects_store[status].turns_left) + "\n"
	return res_text

func _process(_delta):
	if unit:
		text = create_text_label() 
