class_name CreateTurnOrder

static func initial(current_turn: int, all_units: Array[BattleUnit]) -> Array[BattleUnit]:
	var res: Array[BattleUnit]= []

	var turn_order_obj = {}
	var turn_order_arr = []

	for unit in all_units:
		unit.turn_order_index = null

		if !unit.stats.ally and unit.stats.mirror and unit.turn_initialized == current_turn:
			continue

		var turn_speed = unit.stats.combat_stats.turn_speed * (1.0 + randf() * 0.5)
		turn_order_obj[turn_speed] = unit
		turn_order_arr.append(turn_speed)

	turn_order_arr.sort_custom(func(a, b): return a > b)
	
	var index = 0
	for speed in turn_order_arr:
		turn_order_obj[speed].turn_order_index = index 
		res.append(turn_order_obj[speed])
		index +=1

	return res

static func remove_index(index: int, current_turn_order: Array[BattleUnit]) -> Array[BattleUnit]:
	var res: Array[BattleUnit]= []

	for unit in current_turn_order:
		if unit.turn_order_index == index:
			continue
		if unit.turn_order_index > index:
			unit.turn_order_index -= 1
		res.append(unit)

	return res