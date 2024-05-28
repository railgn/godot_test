class_name Target_Funcs

enum ResTargetSide {
	REAL,
	MIRROR,
	BOTH
}

static func find_potential_targets(unit: BattlePlayerUnit, action: Intent.Action, unit_stations:Node) -> Array[Intent.Target]:
	var res: Array[Intent.Target] = []
	var taunt_res: Array[Intent.Target] = []
	var non_invisible_res: Array[Intent.Target] = []

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

	var taunt_node_paths: Array[NodePath] = []
	for effect in unit.stats.status_effects_store:
		var effect_data:= StatusEffects.get_effect(unit.stats.status_effects_store[effect].id)
		if effect_data.optional_properties.has("taunt"):
			var taunt_target_node: BattleUnit = unit.stats.status_effects_store[effect].optional_node_store[0]
			if taunt_target_node:
				if taunt_target_node.stats.alive:
					taunt_node_paths.append(taunt_target_node.get_path())

	var add_all_targets:= func (stations: Array) -> void:
		var res_targets:= get_all_nodes(stations)
		if res_targets.size() > 0:
			res.append(build_res_target(meta, res_targets, []))
			if taunt_node_paths.size() > 0:
				for node_path in res_targets:
					if node_path in taunt_node_paths:
						taunt_res.append(build_res_target(meta, res_targets, []))
		
	var add_single_targets:= func (stations: Array) -> void:
		for station in stations:
			if station:
				for node:BattleUnit in station.get_children():
					var node_path = node.get_path()
					
					res.append(build_res_target(meta, [node_path], []))
					if taunt_node_paths.size() > 0:
						if node_path in taunt_node_paths:
							taunt_res.append(build_res_target(meta, [node_path], []))
					if !invisible_check(node):
						non_invisible_res.append(build_res_target(meta, [node_path], []))
	
	var add_adjacent_targets:= func (stations: Array) -> void:
		for station in stations:
			if station:
				var main_targets: Array[Node] = []
				for node in station.get_children():
					main_targets.append(node)

				for i in range(main_targets.size()):
					var additional_targets: Array[NodePath] = []
					if i > 0:
						additional_targets.append(main_targets[i-1].get_path())
					if i < main_targets.size()-1:
						additional_targets.append(main_targets[i+1].get_path())

					var node_path:= main_targets[i].get_path()
					res.append(build_res_target(meta, [node_path], additional_targets))
					if taunt_node_paths.size() > 0:
						if node_path in taunt_node_paths:
							taunt_res.append(build_res_target(meta, [node_path], additional_targets))
					if !invisible_check(main_targets[i]):
						non_invisible_res.append(build_res_target(meta, [node_path], additional_targets))

	## Res -> Intent.Target
	match res_target_type:
		ActiveSkill.Target.TargetType.ALLY:
			var real_ally_station:= assign_real_ally_station(res_target_side, unit_stations)
			var mirror_ally_station:= assign_mirror_ally_station(res_target_side, unit_stations)

			match res_target_number:
				ActiveSkill.Target.TargetNumber.ALL:
					add_all_targets.call([real_ally_station, mirror_ally_station])
				ActiveSkill.Target.TargetNumber.ALL_SIDE:
					add_all_targets.call([real_ally_station])
					add_all_targets.call([mirror_ally_station])
				ActiveSkill.Target.TargetNumber.ALL_SIDE_SPLIT:
					add_all_targets.call([real_ally_station])
					add_all_targets.call([mirror_ally_station])
				ActiveSkill.Target.TargetNumber.ADJACENT:
					add_adjacent_targets.call([real_ally_station, mirror_ally_station])
				_:	## ONE AND TWO
					add_single_targets.call([real_ally_station, mirror_ally_station])
		ActiveSkill.Target.TargetType.ENEMY:
			var real_enemy_station:= assign_real_enemy_station(res_target_side, unit_stations)
			var mirror_enemy_station:= assign_mirror_enemy_station(res_target_side, unit_stations)

			match res_target_number:
				ActiveSkill.Target.TargetNumber.ALL:
					add_all_targets.call([real_enemy_station, mirror_enemy_station])
				ActiveSkill.Target.TargetNumber.ALL_SIDE:
					add_all_targets.call([real_enemy_station])
					add_all_targets.call([mirror_enemy_station])
				ActiveSkill.Target.TargetNumber.ALL_SIDE_SPLIT:
					add_all_targets.call([real_enemy_station])
					add_all_targets.call([mirror_enemy_station])
				ActiveSkill.Target.TargetNumber.ADJACENT:
					add_adjacent_targets.call([real_enemy_station, mirror_enemy_station])
				_:	## ONE AND TWO
					add_single_targets.call([real_enemy_station, mirror_enemy_station])
		ActiveSkill.Target.TargetType.ANY:
			var real_ally_station:= assign_real_ally_station(res_target_side, unit_stations)
			var mirror_ally_station:= assign_mirror_ally_station(res_target_side, unit_stations)
			var real_enemy_station:= assign_real_enemy_station(res_target_side, unit_stations)
			var mirror_enemy_station:= assign_mirror_enemy_station(res_target_side, unit_stations)

			match res_target_number:
				ActiveSkill.Target.TargetNumber.ALL_SIDE_SPLIT:
					add_all_targets.call([real_ally_station])
					add_all_targets.call([real_enemy_station])
					add_all_targets.call([mirror_ally_station])
					add_all_targets.call([mirror_enemy_station])
				ActiveSkill.Target.TargetNumber.ALL_SIDE:
					add_all_targets.call([real_ally_station, real_enemy_station])
					add_all_targets.call([mirror_ally_station,mirror_enemy_station])
				ActiveSkill.Target.TargetNumber.ALL:
					add_all_targets.call([real_ally_station, real_enemy_station, mirror_ally_station,mirror_enemy_station])
				ActiveSkill.Target.TargetNumber.ADJACENT:
					add_adjacent_targets.call([real_ally_station, real_enemy_station, mirror_ally_station, mirror_enemy_station])
				_: ## One and Two
					add_single_targets.call([real_ally_station, real_enemy_station, mirror_enemy_station, mirror_enemy_station])
		ActiveSkill.Target.TargetType.ALL:
			var real_ally_station:= assign_real_ally_station(res_target_side, unit_stations)
			var mirror_ally_station:= assign_mirror_ally_station(res_target_side, unit_stations)
			var real_enemy_station:= assign_real_enemy_station(res_target_side, unit_stations)
			var mirror_enemy_station:= assign_mirror_enemy_station(res_target_side, unit_stations)
				
			add_all_targets.call([real_ally_station, real_enemy_station, mirror_ally_station,mirror_enemy_station])
		ActiveSkill.Target.TargetType.SELF:
			res.append(build_res_target(meta, [unit.get_path()], []))

	if taunt_res.size() > 0:
		return taunt_res
	elif non_invisible_res.size() > 0:
		return non_invisible_res
	else:
		return res

static func build_res_target(meta: ActiveSkill.Target, node_paths: Array[NodePath], additional_targets: Array[NodePath]) -> Intent.Target:
	var res:= Intent.Target.new()

	var res_main_targets: Array[Intent.Target.TargetStore] = []

	for node_path in node_paths:
		var target_store = Intent.Target.TargetStore.new()
		target_store.node_path = node_path
		# target_store.combat_preview
		res_main_targets.append(target_store)

	var res_additional_targets: Array[Intent.Target.TargetStore] = []
	for node_path in additional_targets:
		var target_store = Intent.Target.TargetStore.new()
		target_store.node_path = node_path
		# target_store.combat_preview
		res_additional_targets.append(target_store)

	res.meta = meta
	res.main_targets = res_main_targets
	res.additional_targets = res_additional_targets

	return res

static func assign_real_ally_station(res_target_side, unit_stations:Node) -> Node:
	var real_ally_station: Node

	match res_target_side:
		ResTargetSide.REAL:
			real_ally_station = unit_stations.get_node("Real").get_node("Player")
		ResTargetSide.BOTH:
			real_ally_station = unit_stations.get_node("Real").get_node("Player")
	
	if real_ally_station:
		if real_ally_station.get_child_count() == 0:
			real_ally_station = null

	return real_ally_station

static func assign_real_enemy_station(res_target_side, unit_stations:Node) -> Node:
	var real_enemy_station: Node

	match res_target_side:
		ResTargetSide.REAL:
			real_enemy_station = unit_stations.get_node("Real").get_node("Enemy")
		ResTargetSide.BOTH:
			real_enemy_station = unit_stations.get_node("Real").get_node("Enemy")
	
	if real_enemy_station:
		if real_enemy_station.get_child_count() == 0:
			real_enemy_station = null

	return real_enemy_station

static func assign_mirror_ally_station(res_target_side, unit_stations:Node) -> Node:
	var mirror_ally_station: Node

	match res_target_side:
		ResTargetSide.MIRROR:
			mirror_ally_station = unit_stations.get_node("Mirror").get_node("Player")
		ResTargetSide.BOTH:
			mirror_ally_station = unit_stations.get_node("Mirror").get_node("Player")
	
	if mirror_ally_station:
		if mirror_ally_station.get_child_count() == 0:
			mirror_ally_station = null

	return mirror_ally_station

static func assign_mirror_enemy_station(res_target_side, unit_stations:Node) -> Node:
	var mirror_enemy_station: Node

	match res_target_side:
		ResTargetSide.MIRROR:
			mirror_enemy_station = unit_stations.get_node("Mirror").get_node("Enemy")
		ResTargetSide.BOTH:
			mirror_enemy_station = unit_stations.get_node("Mirror").get_node("Enemy")
	
	if mirror_enemy_station:
		if mirror_enemy_station.get_child_count() == 0:
			mirror_enemy_station = null

	return mirror_enemy_station

static func get_all_nodes(stations: Array) -> Array[NodePath]:
	var res_targets: Array[NodePath] = []

	for station in stations:
		if station:
			for node in station.get_children():
				res_targets.append(node.get_path())

	return res_targets

static func invisible_check(node: BattleUnit) -> bool:
	var res = false

	for status_effect in node.stats.status_effects_store:
		var effect_data:= StatusEffects.get_effect(node.stats.status_effects_store[status_effect].id)
		if effect_data.optional_properties.has("invisible"):
			res = true

	return res