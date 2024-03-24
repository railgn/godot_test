class_name CharacterClass

var class_id:= "BC_0"
var name:= "default"
var promoted:= false
var skill_tree_id:= "ST_0"

var innate_skills:= PartyMember.SkillsStore.new()
var equipment_slots: Array[Equipment_Slot] = []

##should it be a change basis?
	##think about promotion timing or class switching?
var mapping_stat_growths: Callable = func(level: int) -> Stats.MappingStats:
	var res_mapping_stats = Stats.MappingStats.new()

	res_mapping_stats.strength = level * 1  
	res_mapping_stats.intelligence = level * 1  
	res_mapping_stats.agility = level * 1  
	res_mapping_stats.dexterity = level * 1  
	res_mapping_stats.vitality = level * 1  
	res_mapping_stats.wisdom = level * 1  
	res_mapping_stats.luck = level * 1  

	return res_mapping_stats

class Equipment_Slot:
	var slot_types: Array[Equipment.EquipmentType]
	var max_cost: int
	var equipment_id: String
	func _init(init_slot_type: Array[Equipment.EquipmentType], init_equipment_id:= "" , init_cost:= 1):
		slot_types = init_slot_type
		max_cost = init_cost
		equipment_id = init_equipment_id

func _init(init_id, init_name, init_promoted):
	class_id = init_id
	name = init_name
	promoted = init_promoted

	
