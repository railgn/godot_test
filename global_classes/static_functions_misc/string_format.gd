class_name StringFormat

static func float_to_percent(f: float) -> String:
	var res:= str(roundi(f * 100)) + "%"

	if f > 1.0:
		res = "100%"
	elif f < 0.0:
		res = "0%"

	return res