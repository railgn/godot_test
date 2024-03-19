class_name PartyMember

var DEEP_COPY = DeepCopy.new()

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
		## TODO update skill tree

		var old_innate_skills:= CharacterClasses.get_character_class(class_id).innate_skills
		var new_innate_skills:= CharacterClasses.get_character_class(new_class_id).innate_skills
		
		for skill in old_innate_skills.active_skills:
			if not new_innate_skills.active_skills.has(skill):
				self.delete_skill(skill.id)
		
		for skill in old_innate_skills.passive_skills:
			if not new_innate_skills.passive_skills.has(skill):
				self.delete_skill(skill.id)

		for skill in new_innate_skills.active_skills:
			if not old_innate_skills.active_skills.has(skill):
				self.add_skill(true, skill.id, skill.level)
		
		for skill in new_innate_skills.passive_skills:
			if not old_innate_skills.passive_skills.has(skill):
				self.add_skill(false, skill.id, skill.level)

		class_id = new_class_id
var promoted: bool
var stats:= Stats.new()
var skills_store:= SkillsStore.new():
	set(new_skills_store):
		var added_passives: Array[SkillsStore.SkillStore] = []
		var removed_passives: Array[SkillsStore.SkillStore] = []

		for skill_id in new_skills_store.passive_skills:
			if not skills_store.passive_skills.has(skill_id):
				added_passives.append(new_skills_store.passive_skills[skill_id])
		
		for skill_id in skills_store.passive_skills:
			if not new_skills_store.passive_skills.has(skill_id):
				removed_passives.append(skills_store.passive_skills[skill_id])
		
		for added_passive in added_passives:
			var skill:PassiveSkill = Skills.get_skill(added_passive.id)
			var se_granted:= skill.status_effect_granted

			var effect:= Stats.StatusEffectStore.new(
				se_granted.id, 
				se_granted.turns_left, 
				added_passive.level, 
				se_granted.does_not_expire, 
				se_granted.permanent_persists_outside_battle,
			)			
			stats.add_status_effect(effect)

		for removed_passive in removed_passives:
			var skill:PassiveSkill = Skills.get_skill(removed_passive.id)
			var se_granted:= skill.status_effect_granted

			stats.delete_status_effect(se_granted.id)

		skills_store = new_skills_store

var skill_tree ## TODO skill tree class
var equipment_slots: EquipmentSlots

func _init(init_playable_character_id: String, init_class_id: String, init_promoted: bool):
	playable_character_id = init_playable_character_id
	party_position = Party.DICTIONARY.keys().size() - 1
	level = PlayableCharacters.get_character(init_playable_character_id).recruitment_level
	class_id = init_class_id
	promoted = init_promoted
	skills_store = CharacterClasses.get_character_class(init_class_id).innate_skills
	## TODO skill_tree = Constructor using CharacterClasses.get_character_class(class_id).skill_tree_id 
	equipment_slots = EquipmentSlots.new(CharacterClasses.get_character_class(init_class_id).equipment_slot_array)

class SkillsStore:
	class SkillStore:
		var id: String
		var level: int
		func _init(init_id: String, init_level:= 1):
			id = init_id
			level = init_level

	var active_skills:= {}
	var passive_skills:= {}

func add_skill(active_bool: bool, init_id: String, init_level: int):
	var res_skills_store = DEEP_COPY.copy_skills_store(skills_store)
	if active_bool:
		res_skills_store.active_skills[init_id] = SkillsStore.SkillStore.new(init_id, init_level)
	else:
		res_skills_store.passive_skills[init_id] = SkillsStore.SkillStore.new(init_id, init_level)

	skills_store = res_skills_store

func delete_skill(id_to_delete: String):
	var res_skills_store = DEEP_COPY.copy_skills_store(skills_store)
	if res_skills_store.active_skills.has(id_to_delete):
		res_skills_store.active_skills.erase(id_to_delete)
	elif res_skills_store.passive_skills.has(id_to_delete):
		res_skills_store.passive_skills.erase(id_to_delete)

	skills_store = res_skills_store

class EquipmentSlots:
	func _init(slot_array: Array[CharacterClass.Equipment_Slot]):
	##build object of equipment slots
		##key slot type
		## property - cost
		## property - equipment ID

		pass
