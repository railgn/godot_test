extends Sprite2D

var enemy_unit: BattleEnemyUnit
var sprite_id: String
var sprite_mapper = preload("res://assets/sprites/sprite_mapper.json")

var sprite: Texture2D

func _ready():
	enemy_unit = get_parent()
	var sprite_ids = Enemies.get_enemy(enemy_unit.enemy_id).sprite_ids

	if !enemy_unit.stats.mirror:
		sprite_id = sprite_ids.battle.real
	else:
		sprite_id = sprite_ids.battle.mirror

	sprite = load(sprite_mapper.data[sprite_id])

	self.texture = sprite

func _process(delta):
	self.flip_h = !enemy_unit.stats.mirror
