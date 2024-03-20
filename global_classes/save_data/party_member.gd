class_name PartyMember

var DEEP_COPY = DeepCopy.new()

var playable_character_id: String
var party_position: int
var class_id: String :
	set(new_class_id):
		## TODO update skill tree
		## TODO update equipment slots

		##update stats
		stats.mapping_stats = recalc_mapping_stats(new_class_id, level, equipment_slots)

		##update skills
		var old_innate_skills: SkillsStore
		if class_id:
			old_innate_skills = CharacterClasses.get_character_class(class_id).innate_skills
		else:
			old_innate_skills = CharacterClasses.get_character_class("BC_0").innate_skills

		var new_innate_skills:= CharacterClasses.get_character_class(new_class_id).innate_skills
		
		for skill in old_innate_skills.active_skills:
			if not new_innate_skills.active_skills.has(skill):
				self.delete_skill(old_innate_skills.active_skills[skill].id)
		
		for skill in old_innate_skills.passive_skills:
			if not new_innate_skills.passive_skills.has(skill):
				self.delete_skill(old_innate_skills.passive_skills[skill].id)

		for skill in new_innate_skills.active_skills:
			if not old_innate_skills.active_skills.has(skill):
				self.add_skill(true, 
					new_innate_skills.active_skills[skill].id, 
					new_innate_skills.active_skills[skill].level,
					)
		
		for skill in new_innate_skills.passive_skills:
			if not old_innate_skills.passive_skills.has(skill):
				self.add_skill(false, 
					new_innate_skills.passive_skills[skill].id, 
					new_innate_skills.passive_skills[skill].level,
					)

		class_id = new_class_id
var level: int : 
	set(new_level):
		stats.mapping_stats = recalc_mapping_stats(class_id, new_level, equipment_slots)
		level = new_level
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
## TODO setter on equipment change
## TODO deepcopy equipment slots
var equipment_slots: Array[CharacterClass.Equipment_Slot]

func _init(init_playable_character_id: String, init_class_id: String, init_promoted: bool):
	playable_character_id = init_playable_character_id
	party_position = Party.DICTIONARY.keys().size() - 1
	class_id = init_class_id
	level = PlayableCharacters.get_character(init_playable_character_id).recruitment_level
	promoted = init_promoted	
	skills_store = CharacterClasses.get_character_class(init_class_id).innate_skills
	## TODO skill_tree = Constructor using CharacterClasses.get_character_class(class_id).skill_tree_id 
	equipment_slots = CharacterClasses.get_character_class(init_class_id).equipment_slot_array

class SkillsStore:
	class SkillStore:
		var id: String
		var level: int
		func _init(init_id: String, init_level:= 1):
			id = init_id
			level = init_level

	var active_skills:= {}
	var passive_skills:= {}

func recalc_mapping_stats(func_class_id: String, func_level: int, func_equipment_slots: Array[CharacterClass.Equipment_Slot]) -> Stats.MappingStats:
	var calc_mapping_stat_function:= CharacterClasses.get_character_class(func_class_id).mapping_stat_growths
	var res_mapping_stats = calc_mapping_stat_function.call(func_level)

	## Apply Equipment stats

	return res_mapping_stats
			

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

## add and remove equipment

