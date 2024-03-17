class_name CharacterClass

var class_id:= "BC0"
var name:= "default"
var promoted:= false
var skill_tree_id:= "ST0"

var innate_skills:= PartyMember.Skills_Store.new()
var equipment_slot_array: Array[Equipment_Slot] = [Equipment_Slot.new("Foil", 1)]

##should it be a change basis?
    ##think about promotion timing or class switching?
##promotion or class change should unequip equipment first
    ##then re-equip (if able)
    ##then this function runs
var calc_mapping_stats: Callable = func(level: int, equipment: PartyMember.Equipment_Slots) -> Stats.MappingStats: 
    var res_mapping_stats = Stats.MappingStats.new()
    for stat in res_mapping_stats:
        res_mapping_stats[stat] = level * 1   
    
    ##APPLY EQUIPMENT

    return res_mapping_stats

class Equipment_Slot:
    var slot_type: String ##add enum for this? would be shared by dictionary
    var cost: int
    var equipment_id: String
    func _init(init_slot_type: String, init_cost: int, init_equipment_id:= ""):
        slot_type = init_slot_type
        cost = init_cost
        equipment_id = init_equipment_id

func _init(init_id, init_name, init_promoted):
    class_id = init_id
    name = init_name
    promoted = init_promoted

    