class_name Enemy

var id: String
var name: String
var description := ""
var sprite_id := {
    'real' : 0,
    'mirror' : 0,
}
var skills:= EnemySkillsStore.new()
var stats:= EnemyStatsStore.new()
var drop_table: Array[ItemDrop] = []
var scripted_ai ## scripted ai and dialogue

class EnemySkillsStore:
	class EnemySkillStore:
		var id: String
		var level: int
		var weight: int

		func _init(init_id: String, init_level:= 1, init_weight:=1):
			id = init_id
			level = init_level
			weight = init_weight

	var real: Array[EnemySkillStore] = []
	var mirror: Array[EnemySkillStore] = []

class EnemyStatsStore:
	var real:= Stats.BaseStats.new()
	var mirror:= Stats.BaseStats.new()

class ItemDrop:
	var item_id: String
	var drop_chance: float

	func _init(init_item_id: String, init_drop_chance: float):
		item_id = init_item_id
		drop_chance = init_drop_chance

func _init(init_id: String, init_name: String):
	id = init_id
	name = init_name