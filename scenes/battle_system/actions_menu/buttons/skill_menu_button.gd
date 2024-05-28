class_name SkillMenuButton
extends ActionsMenuButton

var skill: ActiveSkill
var level: int
var unit: BattlePlayerUnit
var dialogue: String
## var cost preiew (array)

func _init(init_skill_id: String, init_level: int, init_unit: BattlePlayerUnit):
	skill = Skills.get_skill(init_skill_id)
	level = init_level
	unit = init_unit
	
	text = skill.name + " Lvl " + str(level)

	disabled = !check_if_skill_usable(unit, skill)

	## save cost preview	

	var cost_resource_string: String = ""

	match skill.cost.resource:
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

	var cost_amount: int = skill.cost.amount.call(level, skill.cost.resource, unit.stats)
	dialogue = str(cost_amount) + " " + cost_resource_string + ": " + skill.description 

func check_if_skill_usable(unit_check: BattlePlayerUnit, skill_check:ActiveSkill) -> bool:
	var usable:= true
	
	var skill_cost_amount = skill_check.cost.amount.call(level, skill_check.cost.resource, unit_check.stats)

	if skill_check.mirror:
		usable = unit_check.stats.mirror

	if usable:
		match skill_check.cost.resource:
			ActiveSkill.SkillCostResource.NONE:
				pass
			ActiveSkill.SkillCostResource.HP:
				if unit_check.stats.combat_stats.hp.current <= skill_cost_amount:
					usable = false
			ActiveSkill.SkillCostResource.MP:
				if unit_check.stats.combat_stats.mp.current < skill_cost_amount:
					usable = false
			ActiveSkill.SkillCostResource.ENERGY:
				if unit_check.stats.combat_stats.energy.current < skill_cost_amount:
					usable = false
			ActiveSkill.SkillCostResource.YOYO:
				pass
			ActiveSkill.SkillCostResource.POWER_CHARGE:
				pass
		
		for prerequisite in skill_check.prerequisites:
			match prerequisite:
				ActiveSkill.PrerequisitesEnum.STATUS_EFFECT:
					if !unit_check.stats.status_effects_store.has(skill_check.prerequisites[prerequisite]):
						usable = false
				ActiveSkill.PrerequisitesEnum.SKILL:
					if (!unit_check.skills_store_player.active_skills.has(skill_check.prerequisites[prerequisite]) 
						and !unit_check.skills_store_player.passive_skills_skills.has(skill_check.prerequisites[prerequisite])):
						usable = false
				ActiveSkill.PrerequisitesEnum.YOYO:
					pass
				ActiveSkill.PrerequisitesEnum.POWER_CHARGE:
					pass

	return usable

func _ready():
	add_to_group("actions_menu_button")
	pressed.connect(_on_pressed)

	focus_entered.connect(_on_focus_entered)
	
func _on_pressed():
	var action:= Intent.Action.new(Intent.Action.Type.SKILL, skill.id, level, Intent.Action.CostPreview.new())

	action_chosen.emit(action)

func _on_focus_entered():
	dialogue_change.emit(dialogue)
	last_control_focus.emit("Skill", self)

	##set cost preview on unit
