class_name GetUnits

static func all_units(UnitStations:Node) -> Array[BattleUnit]:
	var res:Array[BattleUnit] = []

	for player in UnitStations.get_node("Real/Player").get_children():
		res.append(player)
	
	for player in UnitStations.get_node("Mirror/Player").get_children():
		res.append(player)
	
	for enemy in UnitStations.get_node("Real/Enemy").get_children():
		res.append(enemy)
	
	for enemy in UnitStations.get_node("Mirror/Enemy").get_children():
		res.append(enemy)

	return res