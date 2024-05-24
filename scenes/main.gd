extends Node2D

signal battle_ready
var unpause_focus_owner: Control
var viewport: Viewport

func _ready():
	hide()
	Party.initialized.connect(_on_party_initialized)
	for location: BattleLocation in $Map.get_children():
		location.location_chosen.connect(_on_location_chosen)
	viewport = get_viewport()
	
func _on_party_initialized():
	show()
	$Map/BattleLocation.grab_focus()

func _on_location_chosen(location_type: Location.LocationType):
	$Map.hide()
	$Map.set_process(false)

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
			unpause_focus_owner = viewport.gui_get_focus_owner()

			$PauseMenu.show()
			$PauseMenu.get_child(0).grab_focus()
		else:
			$PauseMenu.hide()
			unpause_focus_owner.grab_focus()
