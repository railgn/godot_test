class_name BattlePlayerUnit
extends Node

const player_unit_scene: PackedScene = preload("res://scenes/battle_system/player_unit/player_unit.tscn")

var turn_initialized: int

var playable_character_id: String
var party_position: int
var class_id: String 
var level: int
var stats: Stats
var skills_store: PartyMember.SkillsStore
var equipment_slots: Array[CharacterClass.Equipment_Slot]

static func new_player_unit(unit_save_data: PartyMember, init_turn_initialized:= 1) -> BattlePlayerUnit:
	var unit: BattlePlayerUnit = player_unit_scene.instantiate()
	
	unit.playable_character_id = unit_save_data.playable_character_id
	unit.party_position = unit_save_data.party_position
	unit.class_id = unit_save_data.class_id
	unit.class_id = unit_save_data.class_id
	unit.level = unit_save_data.level
	unit.stats = unit_save_data.stats
	unit.skills_store = unit_save_data.skills_store

	unit.name = PlayableCharacters.get_character(unit_save_data.playable_character_id).name
	unit.turn_initialized = init_turn_initialized
	## sprite assignment?
	## UI should have it's own nodes that pull from here

	return unit

func _ready():

	pass

