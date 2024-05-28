##1 func to create combat preview
	##target controller init or run in actions menu then send to target controller
##1 func to process skill
	##battle system after intent locked in


class_name ProcessSkillCopy

class ProcessMagnitude:
	var damage: int = 0
	var splash_damage: int = 0
	var healing: int = 0

class ProcessCost:
	var resource:= ActiveSkill.SkillCostResource.MP
	var amount: int = 0

class ProcessDamage:
	var damage: int = 0
	var crit: bool = false
	var evade: bool = false

static func process_skill(user: BattleUnit, intent: Intent, unit_stations: Node):
	var skill_info: ActiveSkill = Skills.get_skill(intent.action.id)

	var skill_cost:= calc_skill_cost(skill_info, user, intent)

	var main_target_nodes: Array[Node] = []
	for node_path in intent.target.node_paths:
		main_target_nodes.append(unit_stations.get_node(node_path))	

	var additional_target_nodes: Array[Node] = []
	for node_path in intent.target.node_paths:
		additional_target_nodes.append(unit_stations.get_node(node_path))	
	
	user.affect_resource(true, skill_cost.resource, skill_cost.amount)

	var skill_magnitude:= calc_skill_magnitude(skill_info, user, intent)

	##awaits in here for skill effects
	##user plays animation for using skill
		## targets play affects for take damage
	match skill_info.type:
		ActiveSkill.SkillType.DAMAGE:

			# for target in targets
				#calc damage
				#apply damage


				# if target.check_for_death()
					#if skill_info.active_optional_properties.has("on_kill"):

			pass
		ActiveSkill.SkillType.RECOVERY:


			if skill_info.active_optional_properties.has("revive"):
				#revive hp%
				pass
			pass
		ActiveSkill.SkillType.STATUS:
			pass
		ActiveSkill.SkillType.SPAWN:
			pass

	##play animation
	
	## some checks will be "if" checks within the above match
	for prop in skill_info.active_optional_properties:
		match prop:
			"status_effect_on_user":
				pass
			"status_effect_on_target":
				pass
			"cost_refund_on_bleed":
				var refund:= false
				for target in main_target_nodes:
					if UnitConditionals.is_bleeding(target):
						refund = true
						break
				
				if !refund:
					for target in additional_target_nodes:
						if UnitConditionals.is_bleeding(target):
							refund = true
							break

				if refund:
					user.affect_resource(false, skill_cost.resource, skill_cost.amount)
			_:
				pass

static func calc_skill_cost(skill_info: ActiveSkill, user: BattleUnit, intent: Intent) -> ProcessCost:
	var res:= ProcessCost.new()

	res.resource = skill_info.cost.resource
	res.amount = skill_info.cost.amount.call(intent.action.level, skill_info.cost.resource, user.stats)

	return res


static func calc_skill_magnitude(skill_info: ActiveSkill, user: BattleUnit, intent: Intent) -> ProcessMagnitude:
	var res:= ProcessMagnitude.new()

	res.damage = skill_info.magnitude.damage.call(intent.action.level, user.stats)
	res.splash_damage = skill_info.magnitude.splash_damage.call(intent.action.level, user.stats)
	res.healing = skill_info.magnitude.healing.call(intent.action.level, user.stats)

	return res

static func calc_damage(user: BattleUnit, target: BattleUnit, skill_magnitude: ProcessMagnitude, skill_info: ActiveSkill) -> ProcessDamage:
	var res:= ProcessDamage.new()

	##damage type
		##optional property checks for ignoring def/res

	##crit

	##evade
	var hit_chance:= 1 + user.stats.combat_stats.hit_rate - target.stats.combat_stats.avoid
	
	var evade_rand = (randf() + randf())/2 - 0.01


	if evade_rand > hit_chance:
		res.evade = true










	return res



## do you ever put a take damage function


	
		

