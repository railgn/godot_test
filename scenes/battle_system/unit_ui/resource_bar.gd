class_name ResourceBar
extends ProgressBar

var resource: ActiveSkill.SkillCostResource
var unit: BattleUnit
var combat_preview_bar_min: ProgressBar
var combat_preview_bar_max: ProgressBar
var show_combat_preview: bool = false

var show_cost_preview: bool = false

var over_texture: Texture2D = load("res://assets/ui/progress_bar_over.png")
var under_texture: Texture2D = load("res://assets/ui/progress_bar_under.png")

##SIMPLIFY THE COMBAT BAR INTO A TEXTURE PROGRESS BAR WHERE VALUE = MIN and MAX_VALUE = MAX
## Need to flip the bar
## texture over (min portion) and texture under (max portion above min)	

## if a cost and damage preview are present at the same time, damage preview needs to be shown using (value + cost preview) as the current value

func _init():
	# modulate = Color.GREEN
	show_percentage = false
	pass

func _ready():
	combat_preview_bar_min = ProgressBar.new()
	combat_preview_bar_min.modulate = Color.RED
	combat_preview_bar_min.show_percentage = false
	combat_preview_bar_min.size = size
	combat_preview_bar_min.hide()
	add_child(combat_preview_bar_min)
	combat_preview_bar_max = ProgressBar.new()
	combat_preview_bar_max.modulate = Color.DARK_RED
	combat_preview_bar_max.show_percentage = false
	combat_preview_bar_max.size = size
	combat_preview_bar_max.hide()
	add_child(combat_preview_bar_max)

func update_damage_preview(damage_preview: CombatPreview.DamagePreview):

	var min_damage: int = damage_preview.damage_range[0] * (1 + damage_preview.repeats)
	var max_damage: int = 0

	if damage_preview.damage_range.size() > 1:
		max_damage = damage_preview.damage_range[1] * (1 + damage_preview.repeats)

	if min_damage > value:
		min_damage = int(value)
	if max_damage > value:
		max_damage = int(value)

	## size x
	combat_preview_bar_min.size.x = min_damage / max_value * size.x
	combat_preview_bar_max.size.x = max_damage / max_value * size.x
	## position x
	combat_preview_bar_min.position.x = (value - min_damage)/max_value * size.x
	combat_preview_bar_max.position.x = (value - max_damage)/max_value * size.x

func show_combat_previews():
	combat_preview_bar_min.show()
	combat_preview_bar_max.show()

func hide_combat_previews():
	combat_preview_bar_min.hide()
	combat_preview_bar_max.hide()

func _process(_delta):
	if unit:
		match resource:
			ActiveSkill.SkillCostResource.HP:
				max_value = unit.stats.combat_stats.hp.maximum
				value = unit.stats.combat_stats.hp.current

		
		$Label.text = str(value) + "/" + str(max_value)

		if show_combat_preview and unit.combat_preview_on:
			show_combat_previews()
		else:
			hide_combat_previews()

			




