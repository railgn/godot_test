class_name Target_Funcs

enum ResTargetSide {
	REAL,
	MIRROR,
	BOTH
}

static func find_potential_targets(unit: BattlePlayerUnit, action: Intent.Action, unit_stations:Node) -> Array[Intent.Target]:
	var res: Array[Intent.Target] = []

	## Assignment of meta target info
	var meta = ActiveSkill.Target.new()	

	match action.type:
		Intent.Action.Type.BASIC_ATTACK:
			meta.type = ActiveSkill.Target.TargetType.ENEMY
			meta.number = ActiveSkill.Target.TargetNumber.ONE
			meta.side = ActiveSkill.Target.TargetSide.SAME
		Intent.Action.Type.DEFEND:
			meta.type = ActiveSkill.Target.TargetType.SELF
			meta.number = ActiveSkill.Target.TargetNumber.ONE
			meta.side = ActiveSkill.Target.TargetSide.SAME
		Intent.Action.Type.SKILL:
			var skill_info:= Skills.get_skill(action.id)
			meta.type = skill_info.target.type
			meta.number = skill_info.target.number
			meta.side = skill_info.target.side
		Intent.Action.Type.MIRROR_CAST:
			pass
		Intent.Action.Type.ITEM:
			pass

	## Translation from meta to res
	var res_target_type: ActiveSkill.Target.TargetType
	var res_target_number: ActiveSkill.Target.TargetNumber
	var res_target_side: ResTargetSide
	
	res_target_number = meta.number

	match meta.type:
		ActiveSkill.Target.TargetType.ALLY:
			if unit.stats.ally:
				res_target_type = ActiveSkill.Target.TargetType.ALLY
			else:
				res_target_type = ActiveSkill.Target.TargetType.ENEMY
		ActiveSkill.Target.TargetType.ENEMY:
			if !unit.stats.ally:
				res_target_type = ActiveSkill.Target.TargetType.ALLY
			else:
				res_target_type = ActiveSkill.Target.TargetType.ENEMY
		_:
			res_target_type = meta.type

	match meta.side:
		ActiveSkill.Target.TargetSide.OPPOSITE:
			if !unit.stats.mirror:
				res_target_side = ResTargetSide.MIRROR
			else:
				res_target_side = ResTargetSide.REAL
		ActiveSkill.Target.TargetSide.BOTH:
			res_target_side = ResTargetSide.BOTH
		_: ## SAME
			if unit.stats.mirror:
				res_target_side = ResTargetSide.MIRROR
			else:
				res_target_side = ResTargetSide.REAL

	## Res -> Intent.Target
	match res_target_type:
		ActiveSkill.Target.TargetType.ALLY:
			var real_ally_station: Node
			var mirror_ally_station: Node

			match res_target_side:
				ResTargetSide.REAL:
					real_ally_station = unit_stations.get_node("Real").get_node("Player")
				ResTargetSide.MIRROR:
					mirror_ally_station = unit_stations.get_node("Mirror").get_node("Player")
				ResTargetSide.BOTH:
					real_ally_station = unit_stations.get_node("Real").get_node("Player")
					mirror_ally_station = unit_stations.get_node("Mirror").get_node("Player")

			match res_target_number:
				ActiveSkill.Target.TargetNumber.ALL:
					var res_targets: Array[NodePath] = []
					if real_ally_station:
						for node in real_ally_station.get_children():
							res_targets.append(node.get_path())
					if mirror_ally_station:
						for node in mirror_ally_station.get_children():
							res_targets.append(node.get_path())
					res.append(build_res_target(meta, res_targets, []))
				ActiveSkill.Target.TargetNumber.ALL_SIDE:
					if real_ally_station:
						var res_targets: Array[NodePath] = []
						for node in real_ally_station.get_children():
							res_targets.append(node.get_path())
						res.append(build_res_target(meta, res_targets, []))
					if mirror_ally_station:
						var res_targets: Array[NodePath] = []
						for node in mirror_ally_station.get_children():
							res_targets.append(node.get_path())
						res.append(build_res_target(meta, res_targets, []))
				ActiveSkill.Target.TargetNumber.ALL_SIDE_SPLIT:
					if real_ally_station:
						var res_targets: Array[NodePath] = []
						for node in real_ally_station.get_children():
							res_targets.append(node.get_path())
						res.append(build_res_target(meta, res_targets, []))
					if mirror_ally_station:
						var res_targets: Array[NodePath] = []
						for node in mirror_ally_station.get_children():
							res_targets.append(node.get_path())
						res.append(build_res_target(meta, res_targets, []))
				ActiveSkill.Target.TargetNumber.ADJACENT:
					if real_ally_station:
						var main_targets: Array[Node] = []
						for node in real_ally_station.get_children():
							main_targets.append(node)

						for i in range(main_targets.size()):
							var additional_targets: Array[NodePath] = []
							if i > 0:
								additional_targets.append(main_targets[i-1].get_path())
							if i < main_targets.size()-1:
								additional_targets.append(main_targets[i+1].get_path())

							res.append(build_res_target(meta, [main_targets[i].get_path()], additional_targets))

					if mirror_ally_station:
						var main_targets: Array[Node] = []
						for node in mirror_ally_station.get_children():
							main_targets.append(node)

						for i in range(main_targets.size()):
							var additional_targets: Array[NodePath] = []
							if i > 0:
								additional_targets.append(main_targets[i-1].get_path())
							if i < main_targets.size()-1:
								additional_targets.append(main_targets[i+1].get_path())

							res.append(build_res_target(meta, [main_targets[i].get_path()], additional_targets))
				_:	## ONE AND TWO? Since Two is covered by additional_targets logic in actions_menu
					if real_ally_station:
						for node in real_ally_station.get_children():
							res.append(build_res_target(meta, [node.get_path()], []))
					if mirror_ally_station:
						for node in mirror_ally_station.get_children():
							res.append(build_res_target(meta, [node.get_path()], []))
		ActiveSkill.Target.TargetType.ENEMY:
			var real_enemy_station: Node
			var mirror_enemy_station: Node

			match res_target_side:
				ResTargetSide.REAL:
					real_enemy_station = unit_stations.get_node("Real").get_node("Enemy")
				ResTargetSide.MIRROR:
					mirror_enemy_station = unit_stations.get_node("Mirror").get_node("Enemy")
				ResTargetSide.BOTH:
					real_enemy_station = unit_stations.get_node("Real").get_node("Enemy")
					mirror_enemy_station = unit_stations.get_node("Mirror").get_node("Enemy")

			match res_target_number:
				ActiveSkill.Target.TargetNumber.ALL:
					var res_targets: Array[NodePath] = []
					if real_enemy_station:
						for node in real_enemy_station.get_children():
							res_targets.append(node.get_path())
					if mirror_enemy_station:
						for node in mirror_enemy_station.get_children():
							res_targets.append(node.get_path())
					res.append(build_res_target(meta, res_targets, []))
				ActiveSkill.Target.TargetNumber.ALL_SIDE:
					if real_enemy_station:
						var res_targets: Array[NodePath] = []
						for node in real_enemy_station.get_children():
							res_targets.append(node.get_path())
						res.append(build_res_target(meta, res_targets, []))
					if mirror_enemy_station:
						var res_targets: Array[NodePath] = []
						for node in mirror_enemy_station.get_children():
							res_targets.append(node.get_path())
						res.append(build_res_target(meta, res_targets, []))
				ActiveSkill.Target.TargetNumber.ALL_SIDE_SPLIT:
					if real_enemy_station:
						var res_targets: Array[NodePath] = []
						for node in real_enemy_station.get_children():
							res_targets.append(node.get_path())
						res.append(build_res_target(meta, res_targets, []))
					if mirror_enemy_station:
						var res_targets: Array[NodePath] = []
						for node in mirror_enemy_station.get_children():
							res_targets.append(node.get_path())
						res.append(build_res_target(meta, res_targets, []))
				ActiveSkill.Target.TargetNumber.ADJACENT:
					if real_enemy_station:
						var main_targets: Array[Node] = []
						for node in real_enemy_station.get_children():
							main_targets.append(node)

						for i in range(main_targets.size()):
							var additional_targets: Array[NodePath] = []
							if i > 0:
								additional_targets.append(main_targets[i-1].get_path())
							if i < main_targets.size()-1:
								additional_targets.append(main_targets[i+1].get_path())

							res.append(build_res_target(meta, [main_targets[i].get_path()], additional_targets))

					if mirror_enemy_station:
						var main_targets: Array[Node] = []
						for node in mirror_enemy_station.get_children():
							main_targets.append(node)

						for i in range(main_targets.size()):
							var additional_targets: Array[NodePath] = []
							if i > 0:
								additional_targets.append(main_targets[i-1].get_path())
							if i < main_targets.size()-1:
								additional_targets.append(main_targets[i+1].get_path())

							res.append(build_res_target(meta, [main_targets[i].get_path()], additional_targets))
				_:	## ONE AND TWO
					if real_enemy_station:
						for node in real_enemy_station.get_children():
							res.append(build_res_target(meta, [node.get_path()], []))
					if mirror_enemy_station:
						for node in mirror_enemy_station.get_children():
							res.append(build_res_target(meta, [node.get_path()], []))
		ActiveSkill.Target.TargetType.ANY:
			var real_ally_station: Node
			var mirror_ally_station: Node
			var real_enemy_station: Node
			var mirror_enemy_station: Node
			
			match res_target_side:
				ResTargetSide.REAL:
					real_ally_station = unit_stations.get_node("Real").get_node("Player")
					real_enemy_station = unit_stations.get_node("Real").get_node("Enemy")
				ResTargetSide.MIRROR:
					mirror_ally_station = unit_stations.get_node("Mirror").get_node("Player")
					mirror_enemy_station = unit_stations.get_node("Mirror").get_node("Enemy")
				ResTargetSide.BOTH:
					real_ally_station = unit_stations.get_node("Real").get_node("Player")
					mirror_ally_station = unit_stations.get_node("Mirror").get_node("Player")
					real_enemy_station = unit_stations.get_node("Real").get_node("Enemy")
					mirror_enemy_station = unit_stations.get_node("Mirror").get_node("Enemy")

			match res_target_number:
				ActiveSkill.Target.TargetNumber.ALL_SIDE_SPLIT:
					if real_ally_station:
						var res_targets: Array[NodePath] = []
						for node in real_ally_station.get_children():
							res_targets.append(node.get_path())
						res.append(build_res_target(meta, res_targets, []))
					if mirror_ally_station:
						var res_targets: Array[NodePath] = []
						for node in mirror_ally_station.get_children():
							res_targets.append(node.get_path())
						res.append(build_res_target(meta, res_targets, []))
					if real_enemy_station:
						var res_targets: Array[NodePath] = []
						for node in real_enemy_station.get_children():
							res_targets.append(node.get_path())
						res.append(build_res_target(meta, res_targets, []))
					if mirror_enemy_station:	
						var res_targets: Array[NodePath] = []
						for node in mirror_enemy_station.get_children():
							res_targets.append(node.get_path())
						res.append(build_res_target(meta, res_targets, []))
				ActiveSkill.Target.TargetNumber.ALL_SIDE:
					if real_ally_station:
						var res_targets: Array[NodePath] = []
						for node in real_ally_station.get_children():
							res_targets.append(node.get_path())
						for node in real_enemy_station.get_children():
							res_targets.append(node.get_path())
						res.append(build_res_target(meta, res_targets, []))
					if mirror_ally_station:
						var res_targets: Array[NodePath] = []
						for node in mirror_ally_station.get_children():
							res_targets.append(node.get_path())
						for node in mirror_enemy_station.get_children():
							res_targets.append(node.get_path())
						res.append(build_res_target(meta, res_targets, []))
				ActiveSkill.Target.TargetNumber.ALL:
					var res_targets: Array[NodePath] = []
					if real_ally_station:
						for node in real_ally_station.get_children():
							res_targets.append(node.get_path())
					if mirror_ally_station:
						for node in mirror_ally_station.get_children():
							res_targets.append(node.get_path())
					if real_enemy_station:
						for node in real_enemy_station.get_children():
							res_targets.append(node.get_path())
					if mirror_enemy_station:	
						for node in mirror_enemy_station.get_children():
							res_targets.append(node.get_path())

					res.append(build_res_target(meta, res_targets, []))
				ActiveSkill.Target.TargetNumber.ADJACENT:
					if real_ally_station:
						var main_targets: Array[Node] = []
						for node in real_ally_station.get_children():
							main_targets.append(node)

						for i in range(main_targets.size()):
							var additional_targets: Array[NodePath] = []
							if i > 0:
								additional_targets.append(main_targets[i-1].get_path())
							if i < main_targets.size()-1:
								additional_targets.append(main_targets[i+1].get_path())

							res.append(build_res_target(meta, [main_targets[i].get_path()], additional_targets))

					if mirror_ally_station:
						var main_targets: Array[Node] = []
						for node in mirror_ally_station.get_children():
							main_targets.append(node)

						for i in range(main_targets.size()):
							var additional_targets: Array[NodePath] = []
							if i > 0:
								additional_targets.append(main_targets[i-1].get_path())
							if i < main_targets.size()-1:
								additional_targets.append(main_targets[i+1].get_path())

							res.append(build_res_target(meta, [main_targets[i].get_path()], additional_targets))

					if real_enemy_station:
						var main_targets: Array[Node] = []
						for node in real_enemy_station.get_children():
							main_targets.append(node)

						for i in range(main_targets.size()):
							var additional_targets: Array[NodePath] = []
							if i > 0:
								additional_targets.append(main_targets[i-1].get_path())
							if i < main_targets.size()-1:
								additional_targets.append(main_targets[i+1].get_path())

							res.append(build_res_target(meta, [main_targets[i].get_path()], additional_targets))

					if mirror_enemy_station:
						var main_targets: Array[Node] = []
						for node in mirror_enemy_station.get_children():
							main_targets.append(node)

						for i in range(main_targets.size()):
							var additional_targets: Array[NodePath] = []
							if i > 0:
								additional_targets.append(main_targets[i-1].get_path())
							if i < main_targets.size()-1:
								additional_targets.append(main_targets[i+1].get_path())

							res.append(build_res_target(meta, [main_targets[i].get_path()], additional_targets))
				_: ## One and Two
					if real_ally_station:
						for node in real_ally_station.get_children():
							res.append(build_res_target(meta, [node.get_path()], []))
					if mirror_ally_station:
						for node in mirror_ally_station.get_children():
							res.append(build_res_target(meta, [node.get_path()], []))
					if real_enemy_station:
						for node in real_enemy_station.get_children():
							res.append(build_res_target(meta, [node.get_path()], []))
					if mirror_enemy_station:
						for node in mirror_enemy_station.get_children():
							res.append(build_res_target(meta, [node.get_path()], []))
		ActiveSkill.Target.TargetType.ALL:
			var real_ally_station: Node
			var mirror_ally_station: Node
			var real_enemy_station: Node
			var mirror_enemy_station: Node
			
			match res_target_side:
				ResTargetSide.REAL:
					real_ally_station = unit_stations.get_node("Real").get_node("Player")
					real_enemy_station = unit_stations.get_node("Real").get_node("Enemy")
				ResTargetSide.MIRROR:
					mirror_ally_station = unit_stations.get_node("Mirror").get_node("Player")
					mirror_enemy_station = unit_stations.get_node("Mirror").get_node("Enemy")
				ResTargetSide.BOTH:
					real_ally_station = unit_stations.get_node("Real").get_node("Player")
					mirror_ally_station = unit_stations.get_node("Mirror").get_node("Player")
					real_enemy_station = unit_stations.get_node("Real").get_node("Enemy")
					mirror_enemy_station = unit_stations.get_node("Mirror").get_node("Enemy")
				
			var res_targets: Array[NodePath] = []
			if real_ally_station:
				for node in real_ally_station.get_children():
					res_targets.append(node.get_path())
			if mirror_ally_station:
				for node in mirror_ally_station.get_children():
					res_targets.append(node.get_path())
			if real_enemy_station:
				for node in real_enemy_station.get_children():
					res_targets.append(node.get_path())
			if mirror_enemy_station:	
				for node in mirror_enemy_station.get_children():
					res_targets.append(node.get_path())

			res.append(build_res_target(meta, res_targets, []))
		ActiveSkill.Target.TargetType.SELF:
			res.append(build_res_target(meta, [unit.get_path()], []))

	return res


static func build_res_target(meta: ActiveSkill.Target, node_paths: Array[NodePath], additional_targets: Array[NodePath]) -> Intent.Target:
	var res = Intent.Target.new()

	res.meta = meta
	res.node_paths = node_paths
	res.additional_targets = additional_targets

	return res
