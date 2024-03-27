extends Node

func _ready():
	Party.initialized.connect(on_party_initialized)

func on_party_initialized():
	for party_member in Party.DICTIONARY:
		print(party_member)
		var unit_instance = BattlePlayerUnit.new_player_unit(Party.DICTIONARY[party_member])
		$Real/Player.add_child(unit_instance)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
