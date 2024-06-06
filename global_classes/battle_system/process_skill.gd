class_name ProcessSkill

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

	var targets: Array[ProcessTargetStore] = []
	for target_store in intent.target.main_targets:
		targets.append(ProcessTargetStore.new(unit_stations.get_node(target_store.node_path), target_store.combat_preview))

	for target_store in intent.target.additional_targets:
		targets.append(ProcessTargetStore.new(unit_stations.get_node(target_store.node_path), target_store.combat_preview))
	
	for cost_preview in user.cost_previews:
		user.affect_resource(true, cost_preview.resource, cost_preview.amount)

	##await user skill effect

	for target in targets:
		process_combat(user, target.node, target.combat_preview, skill_info)
		##await skill effect on target 
		##play animation on targets (miss, crit, heal, take damage, etc.)
			##these animations should just be setters on the apply resource function in battleunit
				## if resource goes down/up, play corresponding animation
			##play all simotaneously (await the last one only?)

		if target.node.check_for_death():
			if skill_info.active_optional_properties.has("on_kill"):
				pass

		if target.node.stats.alive:
			if skill_info.active_optional_properties.has("revive"):
				#revive hp%
				pass

	## only checks for things that dont affect target (affect user, other units)
	if skill_info.active_optional_properties.has("status_effect_on_user"):
		pass
	if skill_info.active_optional_properties.has("cost_refund_on_bleed"):
		for target in targets:
			if UnitConditionals.is_bleeding(target.node):
				for cost_preview in user.cost_previews:
					user.affect_resource(false, cost_preview.resource, cost_preview.amount)

static func process_combat(user: BattleUnit, target: BattleUnit, combat_preview: CombatPreview, skill_info: ActiveSkill):
	var evaded = false
	
	for damage_preview in combat_preview.damage:
		var rolled_damage:= calc_damage(user, target, damage_preview, skill_info)
		target.affect_resource(true, damage_preview.resource, rolled_damage.damage)

		if rolled_damage.evade:
			evaded = true
	
	##healing

	##status effects	
	if !evaded:
		pass


static func calc_damage(_user: BattleUnit, _target: BattleUnit, damage_preview: CombatPreview.DamagePreview, _skill_info: ActiveSkill) -> ProcessDamage:
	var res:= ProcessDamage.new()

	##evade roll
	var hit_chance:= damage_preview.hit_chance
	var evade_roll = (randf() + randf())/2 - 0.01

	if evade_roll > hit_chance:
		res.evade = true

	##crit roll
	if res.evade:
		res.crit = false
	else:
		var crit_chance:= damage_preview.crit_chance
		var crit_roll = (randf() + randf())/2 - 0.01

		if crit_roll < crit_chance:
			res.crit = true

	if res.evade:
		res.damage = 0
	else:
		var crit_multiplier:= 1.0

		if res.crit:
			crit_multiplier = 1.5

		## skill info crit multiplier
		
		var average_damage:= 0.0
		var size = damage_preview.damage_range.size()
		for damage_amt in damage_preview.damage_range:
			average_damage = damage_amt / float(size)

		var damage_roll = randf()
		var damage_variance = (average_damage - damage_preview.damage_range[0]) * size
		var pre_crit_damage = damage_preview.damage_range[0] + (damage_roll * damage_variance)

		res.damage = int(pre_crit_damage * crit_multiplier)

	return res