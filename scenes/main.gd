extends Node2D

signal battle_ready

var party_ready:= false

func _ready():
	Party.initialized.connect(_on_party_initialized)
	for location: BattleLocation in $Map.get_children():
		location.location_chosen.connect(_on_location_chosen)

func _on_party_initialized():
	party_ready = true

func _on_location_chosen(location_type: Location.LocationType):
	$Map.hide()

	match location_type:
		Location.LocationType.BATTLE:
			var encounter:= Encounters.get_encounter("ENC_0")
			start_battle(encounter)


func start_battle(encounter: Encounter, _battle_system:= "default", party:= "default"):
	var battle_party: Dictionary

	match party:
		"default":
			battle_party = Party.DICTIONARY
		"_":
			battle_party = Party.DICTIONARY

	var battle_system_instance = BattleSystem.new_battle(battle_party, encounter)
	add_child(battle_system_instance)
	battle_ready.emit()

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = !get_tree().paused
		if get_tree().paused:
			$PauseMenu.show()
			$PauseMenu.get_child(0).grab_focus()
		else:
			$PauseMenu.hide()

	if party_ready:
		show()
	else:
		hide()