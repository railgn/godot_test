extends Node

var DICTIONARY:= {}

func add_enemy(init_id: String, init_name: String) -> void:
	if DICTIONARY.has(init_id):
		print("DUPLICATE ENEMY: ", init_id, " ", init_name)
	else:
		var enemy = Enemy.new()
		enemy.id = init_id
		enemy.name = init_name

		DICTIONARY[init_id] = enemy 

func get_enemy(id: String) -> Enemy:
	if DICTIONARY.has(id):
		return DICTIONARY[id]
	else:
		print("ENEMY DOES NOT EXIST: ", id)
		return Enemy.new()

func _ready():
	add_enemy("E_0", "default")