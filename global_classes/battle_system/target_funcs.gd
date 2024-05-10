class_name Target_Funcs

static func find_potential_targets(unit: BattlePlayerUnit, action: Intent.Action, unit_stations:Node) -> Array[Intent.Target]:
	var res: Array[Intent.Target] = []

	match action.type:
		Intent.Action.Type.BASIC_ATTACK:
			var action_target_type := ActiveSkill.Target.TargetType.ENEMY
			var action_target_number := ActiveSkill.Target.TargetNumber.ONE
			var action_target_side := ActiveSkill.Target.TargetSide.SAME
			
			var target_type: ActiveSkill.Target.TargetType
			var target_number: ActiveSkill.Target.TargetNumber
			var target_side ## mirror, real, both 
			

			match action_target_side:
				ActiveSkill.Target.TargetSide.SAME:
					pass

		Intent.Action.Type.DEFEND:
			pass
		Intent.Action.Type.SKILL:
			pass
		Intent.Action.Type.MIRROR_CAST:
			pass
		Intent.Action.Type.ITEM:
			pass


	var example_target: = unit_stations.get_node("Real").get_node("Enemy").get_child(0)
	var example_path = example_target.get_path()
	
	var example_intent_target:= Intent.Target.new()

	
	var example_meta: = ActiveSkill.Target.new()
	example_meta.type = ActiveSkill.Target.TargetType.ENEMY
	example_meta.number = ActiveSkill.Target.TargetNumber.ONE
	example_meta.side = ActiveSkill.Target.TargetSide.SAME
	
	example_intent_target.meta = example_meta
	example_intent_target.node_paths = [example_path]



	res.append(example_intent_target)

	return res
