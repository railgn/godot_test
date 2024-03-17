class_name PartyMember

var playable_character_id: String
var party_position: int
var level: int : 
	set(new_level):
		var mapping_stat_function:= CharacterClasses.get_character_class(class_id).calc_mapping_stats
		var res_mapping_stats = mapping_stat_function.call(new_level, equipment_slots)
		
		stats.mapping_stats = res_mapping_stats
		level = new_level
var class_id: String :
	set(new_class_id):
		## update skill tree, update skills_store (new innate skills)
		class_id = new_class_id
var promoted: bool
var stats:= Stats.new()
var skills_store:= Skills_Store.new():
	set(new_skills_store):
		##update status effect store based on new passive skills
		skills_store = new_skills_store
var skill_tree ## skill tree class
var equipment_slots: Equipment_Slots

func _init(init_playable_character_id: String, init_class_id: String, init_promoted: bool):
	playable_character_id = init_playable_character_id
	party_position = Party.PARTY.keys().size() - 1
	level = PlayableCharacters.get_character(init_playable_character_id).recruitment_level
	class_id = init_class_id
	promoted = init_promoted
	skills_store = CharacterClasses.get_character_class(init_class_id).innate_skills
	# skill_tree = Constructor using CharacterClasses.get_character_class(class_id).skill_tree_id 
	equipment_slots = Equipment_Slots.new(CharacterClasses.get_character_class(init_class_id).equipment_slot_array)

class Skills_Store:
	class Skill_Store:
		var id: String
		var level: int
	var active_skills = Skill_Store.new()
	var passive_skills = Skill_Store.new()

class Equipment_Slots:
	##build object of equipment slots
		##key slot type
		## property - cost
		## property - equipment ID
	func _init(slot_array: Array[CharacterClass.Equipment_Slot]):
		pass
