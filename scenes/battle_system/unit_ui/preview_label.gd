extends RichTextLabel

var damage_preview: CombatPreview.DamagePreview
var healing_preview: CombatPreview.HealingPreview
var cost_preview: CostPreview

var combat_text: String = ""
var cost_text: String = ""

## custom effects https://www.youtube.com/watch?v=3CZVHxCkpvM
	## bbcode_text = 
		## color change usable vs not usable
		## color change high/low damage/crit/hit rates
		## color change increase/decrease (healing vs cost/damage)
		## different color text for each resource (hp vs mp)

func _ready():
	bbcode_enabled = true
	fit_content = true
	scroll_active = false
	add_theme_font_size_override("normal_font_size", 15)

func update_combat_preview(new_damage_preview: CombatPreview.DamagePreview):
	healing_preview = null
	damage_preview = new_damage_preview
	update_preview_label()

func update_cost_previews(new_cost_preview: CostPreview):
	cost_preview = new_cost_preview
	update_preview_label()

func update_healing_preview(new_healing_preview: CombatPreview.HealingPreview):
	damage_preview = null
	healing_preview = new_healing_preview
	update_preview_label()

func update_preview_label():
	cost_text = ""
	combat_text = ""

	if cost_preview:
		var bbcode_open:= "[right]"
		var bbcode_close:= "[/color][/right]"
		match cost_preview.resource:
			ActiveSkill.SkillCostResource.HP:
				bbcode_open += "[color=RED]"
			ActiveSkill.SkillCostResource.MP:
				bbcode_open += "[color=BLUE]"
		cost_text = bbcode_open + str(cost_preview.amount) + bbcode_close

	var combat_text_strings: Array[String] = []
	if damage_preview:
		var bbcode_open:= "[right]"
		var bbcode_close:= "[/color][/right]"
		match damage_preview.resource:
			ActiveSkill.SkillCostResource.HP:
				bbcode_open += "[color=RED]"
			ActiveSkill.SkillCostResource.MP:
				bbcode_open += "[color=BLUE]"
		combat_text_strings.append(bbcode_open + str(damage_preview.damage_range) + ("" if damage_preview.repeats == 0 else " x" + str(damage_preview.repeats + 1)) + bbcode_close) 
		combat_text_strings.append("[right]" + "hit: " + str(StringFormat.float_to_percent(damage_preview.hit_chance)))
		combat_text_strings.append("crit: " + str(StringFormat.float_to_percent(damage_preview.crit_chance)) + "[/right]")
		
	if healing_preview:
		var bbcode_open:= "[right]"
		var bbcode_close:= "[/color][/right]"
		match healing_preview.resource:
			ActiveSkill.SkillCostResource.HP:
				bbcode_open += "[color=LIGHT_GREEN]"
			ActiveSkill.SkillCostResource.MP:
				bbcode_open += "[color=LIGHT_BLUE]"
		combat_text_strings.append(bbcode_open + str(healing_preview.amount) + bbcode_close)

	for preview_text_string in combat_text_strings:
		combat_text += preview_text_string + "\n"