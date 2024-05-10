class_name SkillMenuButton
extends ActionsMenuButton

var skill: ActiveSkill
var level: int
var unit: BattlePlayerUnit

func _init(init_skill_id: String, init_level: int, init_unit: BattlePlayerUnit):
	skill = Skills.get_skill(init_skill_id)
	level = init_level
	unit = init_unit
	
	text = skill.name + " Lvl " + str(level)

	disabled = !check_if_skill_usable(unit, skill)	

func check_if_skill_usable(unit_check: BattlePlayerUnit, skill_check:ActiveSkill) -> bool:
	var usable:= true
	
	var skill_cost_amount = skill_check.cost.amount.call(level, skill_check.cost.resource, unit_check.stats)

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
	var action:= Intent.Action.new(Intent.Action.Type.SKILL, skill.id)

	action_chosen.emit(action)

func _on_focus_entered():
	dialogue_change.emit(skill.description)
