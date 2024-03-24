class_name Equipment

var DEEP_COPY = DeepCopy.new()

enum EquipmentType {
    FOIL,
    YOYO,
	NONE
}

var id:= ""
var name:= ""
var description:= ""
var type: EquipmentType
var cost:= 1

var equipment_base_adder: Callable = func(original_stats: Stats.BaseStats) -> Stats.BaseStats:
	var res_base_stats = DEEP_COPY.copy_base_stats(original_stats)
	return res_base_stats

var mapping_stat_adder: Callable = func(original_stats: Stats.MappingStats) -> Stats.MappingStats:
	var res_mapping_stats = DEEP_COPY.copy_mapping_stats(original_stats)
	return res_mapping_stats
var mapping_stat_multiplier: Callable = func(original_stats: Stats.MappingStats) -> Stats.MappingStats:
	var res_mapping_stats = DEEP_COPY.copy_mapping_stats(original_stats)
	return res_mapping_stats

var skills_provided:= PartyMember.SkillsStore.new()
var sell_price:= 1

func _init(init_id: String, init_name: String, init_type: Equipment.EquipmentType):
	id = init_id
	name = init_name
	type = init_type