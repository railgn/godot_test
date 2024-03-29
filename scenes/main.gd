extends Node

signal start_battle_signal

func _ready():
	Party.initialized.connect(_on_party_initialized)

func _on_party_initialized():

	## replace with a query on encounter dictionary
	var encounter:= Encounter.new()

	start_battle(encounter)

func start_battle(encounter: Encounter, _battle_system:= "default", party:= "default"):
	##hide current scene
	##loading screen

	var battle_party: Dictionary

	match party:
		"default":
			battle_party = Party.DICTIONARY
		"_":
			battle_party = Party.DICTIONARY

	var battle_system_instance = BattleSystem.new_battle(battle_party, encounter)
	add_child(battle_system_instance)
	start_battle_signal.emit()

func _process(_delta):
	pass
