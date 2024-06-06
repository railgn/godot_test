extends RichTextLabel

var unit: BattleUnit
var combat_preview: CombatPreview

##images for status_effects

func _init():
	fit_content = true
	bbcode_enabled = true

func update_combat_preview(new_combat_preview: CombatPreview):
	combat_preview = new_combat_preview
	update_preview_label()

func update_preview_label():
	text = ""
	if combat_preview:		
		var status_string_arr: Array[String] = []
		for status in combat_preview.status:
			var status_info:= StatusEffects.get_effect(status.status_id)
			##add image instead of name
			status_string_arr.append(status_info.name + ": " +str(StringFormat.float_to_percent(status.infliction_chance)) + " Turn(s): " + str(status.duration))
		
		var status_label_string:= ""

		for status_string in status_string_arr:
			status_label_string += status_string + "\n"

		text = "[right]" + status_label_string + "[/right]"

func _process(_add_global_constantdelta):
	if unit:
		if unit.combat_preview_on or unit.cost_previews_on:
			show()
		else:
			hide()	

		