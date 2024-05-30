class_name Intent

var action: Action
var target: Target
# var user: BattleUnit 

class Action:
	
	enum Type {
		BASIC_ATTACK,
		DEFEND,
		SKILL,
		MIRROR_CAST,
		ITEM,
	}

	var type: Type
	var id: String
	var level: int
	var cost_preview: Array[CostPreview]

	func _init(init_type: Type, init_id: String, init_level: int, init_cost_preview: Array[CostPreview]):
		type = init_type
		id = init_id
		level = init_level
		cost_preview = init_cost_preview

class Target:
	class TargetStore:		
		var node_path:NodePath
		var combat_preview: CombatPreview  

	var meta: ActiveSkill.Target
	var main_targets: Array[TargetStore]
	var additional_targets: Array[TargetStore]





	
