extends Node

var DICTIONARY:= {}
var DEEP_COPY = DeepCopy.new()

func add_equipment(init_id: String, init_name: String, init_type: Equipment.EquipmentType) -> void:
	if DICTIONARY.has(init_id):
		print("DUPLICATE EQUIPMENT: ", init_id, " ", init_name, init_type)
	else:
		DICTIONARY[init_id] = Equipment.new(init_id, init_name, init_type)


func get_equipment(id: String) -> Equipment:
	if DICTIONARY.has(id):
		return DICTIONARY[id]
	else:
		print("EQUIPMENT DOES NOT EXIST: ", id)
		return Equipment.new("", "", Equipment.EquipmentType.NONE)

func _ready():
	add_equipment("EQ_0", "default", Equipment.EquipmentType.NONE)
	
	add_equipment("EQ_1", "equipment test", Equipment.EquipmentType.FOIL)
	DICTIONARY.EQ_1.equipment_base_adder = func(original_stats: Stats.BaseStats) -> Stats.BaseStats:
		var res_base_stats = DEEP_COPY.copy_base_stats(original_stats)
		res_base_stats.physical.attack += 1
		return res_base_stats
	DICTIONARY.EQ_1.mapping_stat_adder = func(original_stats: Stats.MappingStats) -> Stats.MappingStats:
		var res_mapping_stats = DEEP_COPY.copy_mapping_stats(original_stats)
		res_mapping_stats.intelligence += 10
		return res_mapping_stats
	DICTIONARY.EQ_1.mapping_stat_multiplier = func(original_stats: Stats.MappingStats) -> Stats.MappingStats:
		var res_mapping_stats = DEEP_COPY.copy_mapping_stats(original_stats)
		res_mapping_stats.intelligence *= 5
		return res_mapping_stats


