extends RichTextLabel

var unit: BattleUnit
var combat_preview: CombatPreview
var cost_previews: Array[CostPreview]
var cost_text: String = ""
var combat_text: String = ""

## custom effects https://www.youtube.com/watch?v=3CZVHxCkpvM
	## bbcode_text = 
		## color change usable vs not usable
		## color change high/low damage/crit/hit rates
		## color change increase/decrease (healing vs cost/damage)
		## different color text for each resource (hp vs mp)
##images for status_effects

## would be nice to align damage for each resource bar, would need to make that text a child of the resource bar. could do that from here?
	## add child and then adjust position based on resource bar position

func _init():
	fit_content = true
	bbcode_enabled = true


func update_combat_preview(new_combat_preview: CombatPreview):
	combat_preview = new_combat_preview
	update_preview_label()

func update_cost_previews(new_cost_previews: Array[CostPreview]):
	cost_previews = new_cost_previews
	update_preview_label()

func update_preview_label():
	text = ""
	cost_text = ""
	combat_text = ""

	var cost_label_strings = []
	for cost_preview in cost_previews:
		match cost_preview.resource:
			ActiveSkill.SkillCostResource.HP:
				pass
			ActiveSkill.SkillCostResource.MP:
				pass
		cost_label_strings.append(str([cost_preview.amount]))	
			
	var combat_label_strings = []
	if combat_preview:
		for damage in combat_preview.damage:

			match damage.resource:
				ActiveSkill.SkillCostResource.HP:
					##bbcode here
					pass
				ActiveSkill.SkillCostResource.MP:
					pass
			combat_label_strings.append(str(damage.damage_range) + "" if damage.repeats == 0 else " x" + str(damage.repeats + 1))
			combat_label_strings.append("hit: " + str(StringFormat.float_to_percent(damage.hit_chance)))
			combat_label_strings.append("crit: " + str(StringFormat.float_to_percent(damage.crit_chance)))
		
		if combat_preview.healing:
			var resource_string: String
			match combat_preview.healing.resource:
				ActiveSkill.SkillCostResource.HP:
					resource_string = "HP"				
				ActiveSkill.SkillCostResource.MP:
					resource_string = "MP"				
			combat_label_strings.append(resource_string + " Healing: " + str(combat_preview.healing.amount))

		for status in combat_preview.status:
			var status_info:= StatusEffects.get_effect(status.status_id)
			##add image instead of name
			combat_label_strings.append(status_info.name + ": " +str(StringFormat.float_to_percent(status.infliction_chance)) + " Turn(s): " + str(status.duration))

	for cost_label_string in cost_label_strings:
		cost_text += cost_label_string + "\n"
	for combat_label_string in combat_label_strings:
		combat_text += combat_label_string + "\n"

	text = "[right]" + cost_text + combat_text + "[/right]"


func _process(_add_global_constantdelta):
	if unit:
		if unit.combat_preview_on or unit.cost_previews_on:
			show()
		else:
			hide()	

		