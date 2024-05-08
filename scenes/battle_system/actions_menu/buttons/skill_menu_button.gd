class_name SkillMenuButton
extends ActionsMenuButton

var skill: ActiveSkill
var unit: BattlePlayerUnit

func _init(init_skill_id: String, init_unit: BattlePlayerUnit):
	skill = Skills.get_skill(init_skill_id)
	unit = init_unit
	
	text = skill.name

	disabled = !check_if_skill_usable(unit, skill)	

func check_if_skill_usable(unit_check: BattlePlayerUnit, skill_check:ActiveSkill) -> bool:
	var usable:= true

	##calc skill cost
	##match SkillCostResource
	##resource check (current > skill cost)


	##for prerequisite in prerequisites
		##match

	
	
	
	return usable





func _ready():
	pressed.connect(_on_pressed)

func _on_pressed():
	var action:= Intent.Action.new(Intent.Action.Type.SKILL, skill.id)

	action_chosen.emit(action)