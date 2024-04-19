extends Sprite3D

var player_unit: BattlePlayerUnit
var sprite_id: String
var sprite_mapper = preload("res://assets/sprites/sprite_mapper.json")



var sprite: Texture2D

func _ready():
	player_unit = get_parent()
	var sprite_ids = PlayableCharacters.get_character(player_unit.playable_character_id).sprite_ids

	if !player_unit.stats.mirror:
		sprite_id = sprite_ids.battle.real
	else:
		sprite_id = sprite_ids.battle.mirror

	sprite = load(sprite_mapper.data[sprite_id])

	self.texture = sprite

func _process(delta):
	self.flip_h = player_unit.stats.mirror

