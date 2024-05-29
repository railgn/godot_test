##1 func to create combat preview
	## Intent -> Intent with combat previews
	## 
	##target controller init or run in actions menu then send to target controller
##1 func to process skill
	##battle system after intent locked in

class_name ProcessSkill

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

class ProcessTargetStore:
	var node: BattleUnit
	var combat_preview: CombatPreview

	func _init(init_node: BattleUnit, init_combat_preview: CombatPreview):
		node = init_node
		combat_preview = init_combat_preview

static func process_skill(user: BattleUnit, intent: Intent, unit_stations: Node):
	var skill_info: ActiveSkill = Skills.get_skill(intent.action.id)

	var skill_cost:= calc_skill_cost(skill_info, user, intent)

	var targets: Array[ProcessTargetStore] = []
	for target_store in intent.target.main_targets:
		targets.append(ProcessTargetStore.new(unit_stations.get_node(target_store.node_path), target_store.combat_preview))

	for target_store in intent.target.additional_targets:
		targets.append(ProcessTargetStore.new(unit_stations.get_node(target_store.node_path), target_store.combat_preview))
	
	user.affect_resource(true, skill_cost.resource, skill_cost.amount)

	##awaits in here for skill effects
	##user plays animation for using skill
		## targets play affects for take damage

	# for target in targets

		##use all props from 



		#calc damage
		#apply damage
		#apply status effects
		

		# if target.check_for_death()
			#if skill_info.active_optional_properties.has("on_kill"):

		# if skill_info.active_optional_properties.has("revive"):
		# 	#revive hp%
		# 	pass

	## if attacking move, and it misses, dont apply status effects
		

	##play animation on targets (miss, crit, heal, take damage, etc.)
		##these animations should just be setters on the apply resource function in battleunit
			## if resource goes down/up, play corresponding animation
	
	## only checks for things that dont affect target (affect user, other units)
	for prop in skill_info.active_optional_properties:
		match prop:
			"status_effect_on_user":
				pass
			"cost_refund_on_bleed":
				for target in targets:
					if UnitConditionals.is_bleeding(target.node):
						user.affect_resource(false, skill_cost.resource, skill_cost.amount)
						break
			_:
				pass

static func calc_skill_cost(skill_info: ActiveSkill, user: BattleUnit, intent: Intent) -> ProcessCost:
	var res:= ProcessCost.new()

	res.resource = skill_info.cost.resource
	res.amount = skill_info.cost.amount.call(intent.action.level, skill_info.cost.resource, user.stats)

	return res

static func calc_damage(user: BattleUnit, target: BattleUnit, skill_magnitude: ProcessMagnitude, skill_info: ActiveSkill) -> ProcessDamage:
	var res:= ProcessDamage.new()

	##crit roll

	##evade roll
	var hit_chance:= 1 + user.stats.combat_stats.hit_rate - target.stats.combat_stats.avoid
	
	var evade_roll = (randf() + randf())/2 - 0.01

	if evade_roll > hit_chance:
		res.evade = true



	return res