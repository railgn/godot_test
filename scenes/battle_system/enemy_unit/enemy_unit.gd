class_name BattleEnemyUnit
extends BattleUnit

# const enemy_unit_scene: PackedScene = preload("res://scenes/battle_system/enemy_unit/enemy_unit.tscn")

var enemy_id: String
var description: String
var skills_store_enemy: Array[Enemy.EnemySkillsStore.EnemySkillStore]
var drop_table: Array[Enemy.ItemDrop]
var scripted_ai

static func new_enemy_unit(enemy_data: Encounter.EnemyData, mirror: bool, init_turn_initialized:= 1) -> BattleEnemyUnit:
	var enemy_unit_scene: PackedScene = load("res://scenes/battle_system/enemy_unit/enemy_unit.tscn")
	var unit: BattleEnemyUnit = enemy_unit_scene.instantiate()
	var dictionary_data := Enemies.get_enemy(enemy_data.enemy_id)
	

	unit.enemy_id = enemy_data.enemy_id
	unit.turn_initialized = init_turn_initialized
	unit.name = dictionary_data.name
	unit.level = enemy_data.level
	unit.description = dictionary_data.description

	unit.stats= Stats.new()
	unit.stats.mirror = mirror
	unit.stats.player = false
	unit.stats.ally = false


	unit.stats.base_stats = dictionary_data.stats.real if !mirror else dictionary_data.stats.mirror
	unit.skills_store_enemy = dictionary_data.skills.real if !mirror else dictionary_data.skills.mirror
	unit.drop_table = dictionary_data.drop_table
	unit.scripted_ai = dictionary_data.scripted_ai

	##overrides
	# for prop in overrides:
		#switch statement for each type of property

	## sprite assignment?
	## UI should have it's own nodes that pull from here

	return unit

func _ready():
	pass