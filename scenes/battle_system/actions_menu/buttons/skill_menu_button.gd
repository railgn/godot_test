class_name SkillMenuButton
extends ActionsMenuButton

var skill_info: ActiveSkill
var level: int
var unit: BattlePlayerUnit
var dialogue: String
var cost_previews: Array[CostPreview]

func _init(init_skill_id: String, init_level: int, init_unit: BattlePlayerUnit):
	skill_info = Skills.get_skill(init_skill_id)
	level = init_level
	unit = init_unit
	
	text = skill_info.name + " Lvl " + str(level)
	cost_previews = CreateCostPreview.create_cost_preview(unit, skill_info, level)

	disabled = false
	for cost_preview in cost_previews:
		if !cost_preview.usable:
			disabled = true
			break 

	var cost_resource_string: String = ""

	match skill_info.cost.resource:
		ActiveSkill.SkillCostResource.HP:
			cost_resource_string = "HP"
		ActiveSkill.SkillCostResource.MP:
			cost_resource_string = "MP"
		ActiveSkill.SkillCostResource.ENERGY:
			cost_resource_string = "ENERGY"
		ActiveSkill.SkillCostResource.YOYO:
			cost_resource_string = "YOYO"
		ActiveSkill.SkillCostResource.POWER_CHARGE:
			cost_resource_string = "POWER CHARGE"
		ActiveSkill.SkillCostResource.NONE:
			cost_resource_string = ""

	var cost_amount: int = skill_info.cost.amount.call(level, skill_info.cost.resource, unit.stats)
	dialogue = str(cost_amount) + " " + cost_resource_string + ": " + skill_info.description 

func _ready():
	add_to_group("actions_menu_button")
	pressed.connect(_on_pressed)

	focus_entered.connect(_on_focus_entered)
	
func _on_pressed():
	var action:= Intent.Action.new(Intent.Action.Type.SKILL, skill_info.id, level, cost_previews)

	action_chosen.emit(action)

func _on_focus_entered():
	dialogue_change.emit(dialogue)
	last_control_focus.emit("Skill", self)

	unit.cost_previews_on = true
	unit.cost_previews = cost_previews
