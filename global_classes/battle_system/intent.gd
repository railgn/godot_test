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

	func _init(init_type: Type, init_id: String):
		type = init_type
		id = init_id


class Target:
	var meta: ActiveSkill.Target
	var node_paths
