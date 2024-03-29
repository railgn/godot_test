class_name BattleSystem
extends Node

const battle_system_scene: PackedScene = preload("res://scenes/battle_system/battle_system.tscn")

var main: Node
var party: Dictionary
var encounter: Encounter

static func new_battle(init_party: Dictionary, init_encounter: Encounter) -> BattleSystem:
	var battle_system: BattleSystem = battle_system_scene.instantiate()

	battle_system.party = init_party
	battle_system.encounter = init_encounter

	return battle_system

func _ready():
	main = get_parent()
	main.start_battle_signal.connect(_on_start_battle_signal)

func _on_start_battle_signal():
	for party_member in party:
		var unit_instance = BattlePlayerUnit.new_player_unit(Party.DICTIONARY[party_member])
		$Real/Player.add_child(unit_instance)

	# for enemy in enecounter

	#enemy unit
	#creates unit node
	# gets dictionary info using enemy id
	# applies level where applicable (stats, skills)
	# for prop in overrides:
		#switch statement for each type of property

	
		
