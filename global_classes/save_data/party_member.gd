class_name PartyMember

var DEEP_COPY = DeepCopy.new()
var UPDATE_STATS = UpdateStats.new()

var playable_character_id: String
var party_position: int
var class_id: String :
	set(new_class_id):
		## TODO update skill tree

		## TODO update equipment slots
		if class_id:
			equipment_slots = CharacterClasses.get_character_class(new_class_id).equipment_slots

			## keep equipment IDs if slots are available

		##update stats
		stats.mapping_stats = UPDATE_STATS.recalc_mapping_stats(new_class_id, level, equipment_slots)

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
		stats.mapping_stats = UPDATE_STATS.recalc_mapping_stats(class_id, new_level, equipment_slots)
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
var equipment_slots: Array[CharacterClass.Equipment_Slot]:
	set(new_equipment_slots):
		##update mapping stats
		stats.mapping_stats = UPDATE_STATS.recalc_mapping_stats(class_id, level, new_equipment_slots)
		##update equipment bases
		stats.equipment_bases = UPDATE_STATS.recalc_equipment_bases(new_equipment_slots)
		
		##change skills
		var old_equipment_skills:= SkillsStore.new()
		for slot in equipment_slots:
			if slot.equipment_id != "EQ_0" and slot.equipment_id:
				var equip: Equipment = Equipments.get_equipment(slot.equipment_id)
				for active_skill_id in equip.skills_provided.active_skills:
					old_equipment_skills.active_skills[active_skill_id] = equip.skills_provided.active_skills[active_skill_id]
				for passive_skill_id in equip.skills_provided.passive_skills:
					old_equipment_skills.passive_skills[passive_skill_id] = equip.skills_provided.passive_skills[passive_skill_id]

		var new_equipment_skills:= SkillsStore.new()
		for slot in new_equipment_slots:
			if slot.equipment_id != "EQ_0" and slot.equipment_id:
				var equip: Equipment = Equipments.get_equipment(slot.equipment_id)
				for active_skill_id in equip.skills_provided.active_skills:
					new_equipment_skills.active_skills[active_skill_id] = equip.skills_provided.active_skills[active_skill_id]
				for passive_skill_id in equip.skills_provided.passive_skills:
					new_equipment_skills.passive_skills[passive_skill_id] = equip.skills_provided.passive_skills[passive_skill_id]

		##abstract this section? input (new and old skills), returns array of skills to add and of skills to delete
		for skill in old_equipment_skills.active_skills:
			if not new_equipment_skills.active_skills.has(skill):
				self.delete_skill(old_equipment_skills.active_skills[skill].id)
		
		for skill in old_equipment_skills.passive_skills:
			if not new_equipment_skills.passive_skills.has(skill):
				self.delete_skill(old_equipment_skills.passive_skills[skill].id)

		for skill in new_equipment_skills.active_skills:
			if not old_equipment_skills.active_skills.has(skill):
				self.add_skill(true, 
					new_equipment_skills.active_skills[skill].id, 
					new_equipment_skills.active_skills[skill].level,
					)
		
		for skill in new_equipment_skills.passive_skills:
			if not old_equipment_skills.passive_skills.has(skill):
				self.add_skill(false, 
					new_equipment_skills.passive_skills[skill].id, 
					new_equipment_skills.passive_skills[skill].level,
					)

		equipment_slots = new_equipment_slots

func _init(init_playable_character_id: String, init_class_id: String, init_promoted: bool):
	playable_character_id = init_playable_character_id
	party_position = Party.DICTIONARY.keys().size() - 1
	class_id = init_class_id
	level = PlayableCharacters.get_character(init_playable_character_id).recruitment_level
	promoted = init_promoted	
	skills_store = CharacterClasses.get_character_class(init_class_id).innate_skills
	## TODO skill_tree = Constructor using CharacterClasses.get_character_class(class_id).skill_tree_id 
	equipment_slots = CharacterClasses.get_character_class(init_class_id).equipment_slots

class SkillsStore:
	class SkillStore:
		var id: String
		var level: int
		func _init(init_id: String, init_level:= 1):
			id = init_id
			level = init_level

	var active_skills:= {}
	var passive_skills:= {}			

func add_skill(active_bool: bool, init_id: String, init_level: int) -> void:
	var res_skills_store = DEEP_COPY.copy_skills_store(skills_store)
	if active_bool:
		res_skills_store.active_skills[init_id] = SkillsStore.SkillStore.new(init_id, init_level)
	else:
		res_skills_store.passive_skills[init_id] = SkillsStore.SkillStore.new(init_id, init_level)

	skills_store = res_skills_store

func delete_skill(id_to_delete: String) -> void:
	var res_skills_store = DEEP_COPY.copy_skills_store(skills_store)
	if res_skills_store.active_skills.has(id_to_delete):
		res_skills_store.active_skills.erase(id_to_delete)
	elif res_skills_store.passive_skills.has(id_to_delete):
		res_skills_store.passive_skills.erase(id_to_delete)

	skills_store = res_skills_store

func add_equipment(equipment_id: String, slot_index: int) -> void:
	var equip:= Equipments.get_equipment(equipment_id)
	var slot: CharacterClass.Equipment_Slot
	if slot_index < equipment_slots.size():
		slot = equipment_slots[slot_index]

	if equip and slot:
		if equip.type in slot.slot_types and equip.cost <= slot.max_cost:
			var res_equip_slots = DEEP_COPY.copy_equipment_slot_array(equipment_slots)
			res_equip_slots[slot_index].equipment_id = equipment_id
			equipment_slots = res_equip_slots

func remove_equipment(slot_index: int) -> void:
	if slot_index < equipment_slots.size():
		var res_equip_slots = DEEP_COPY.copy_equipment_slot_array(equipment_slots)
		res_equip_slots[slot_index].equipment_id = ""
		equipment_slots = res_equip_slots
		
		