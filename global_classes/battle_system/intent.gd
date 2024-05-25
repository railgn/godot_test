class_name Intent

var action: Action
var target: Target

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

	func _init(init_type: Type, init_id: String, init_level: int):
		type = init_type
		id = init_id
		level = init_level

class Target:
	var meta: ActiveSkill.Target
	var node_paths: Array[NodePath]
	var additional_targets: Array[NodePath]
	
