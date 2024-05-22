extends Sprite2D

var player_unit: BattlePlayerUnit
var sprite_id: String
var sprite_mapper = preload("res://assets/sprites/sprite_mapper.json")

var sprite: Texture2D
@export var units_turn_offset: int = 150

func _ready():
	player_unit = get_parent()
	var sprite_ids = PlayableCharacters.get_character(player_unit.playable_character_id).sprite_ids

	if !player_unit.stats.mirror:
		sprite_id = sprite_ids.battle.real
	else:
		sprite_id = sprite_ids.battle.mirror

	sprite = load(sprite_mapper.data[sprite_id])

	self.texture = sprite

	player_unit.units_turn_change.connect(_on_units_turn)

func _process(_delta):
	self.flip_h = !player_unit.stats.mirror

func _on_units_turn(_turn_order_index, new_units_turn):
	if new_units_turn:
		offset.x = units_turn_offset
	else:
		offset.x = 0
