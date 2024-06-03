class_name ResourceBar
extends ProgressBar

var resource: ActiveSkill.SkillCostResource
var unit: BattleUnit
var combat_preview_bar_min: ProgressBar
var combat_preview_bar_max: ProgressBar
var show_combat_preview: bool = false

var show_cost_preview: bool = false
var cost_preview_bar: ProgressBar

##SIMPLIFY THE COMBAT BAR INTO A TEXTURE PROGRESS BAR WHERE VALUE = MIN and MAX_VALUE = MAX
## Need to flip the bar
## texture over (min portion) and texture under (max portion above min)	

## if a cost and damage preview are present at the same time, damage preview needs to be shown using (value + cost preview) as the current value

func _init():
	show_percentage = false

func _ready():
	combat_preview_bar_min = ProgressBar.new()
	combat_preview_bar_min.show_percentage = false
	combat_preview_bar_min.size = size
	combat_preview_bar_min.hide()
	combat_preview_bar_min.z_index = 1
	add_child(combat_preview_bar_min)
	combat_preview_bar_max = ProgressBar.new()
	combat_preview_bar_max.show_percentage = false
	combat_preview_bar_max.size = size
	combat_preview_bar_max.hide()
	combat_preview_bar_max.z_index = 1
	add_child(combat_preview_bar_max)
	cost_preview_bar = ProgressBar.new()
	cost_preview_bar.modulate = Color.DARK_RED
	cost_preview_bar.show_percentage = false
	cost_preview_bar.size = size
	cost_preview_bar.hide()
	cost_preview_bar.z_index = 1
	add_child(cost_preview_bar)

func update_damage_preview(damage_preview: CombatPreview.DamagePreview):
	combat_preview_bar_min.modulate = Color.RED
	combat_preview_bar_max.modulate = Color.DARK_RED

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

func update_healing_preview(healing_amount: int):
	combat_preview_bar_min.modulate = Color.LIGHT_GREEN

	var healing: int = healing_amount

	if (healing + value) > max_value:
		healing = int(max_value) - int(value)

	combat_preview_bar_min.position.x = (value + healing)/max_value * size.x
	combat_preview_bar_min.size.x = healing / max_value * size.x

	combat_preview_bar_max.size.x = 0

func update_cost_preview(cost_preview: CostPreview):
	var cost: int = cost_preview.amount

	if cost > value:
		cost = int(value)

	## size x
	cost_preview_bar.size.x = cost / max_value * size.x
	## position x
	cost_preview_bar.position.x = (value - cost)/max_value * size.x

func show_combat_previews():
	combat_preview_bar_min.show()
	combat_preview_bar_max.show()

func hide_combat_previews():
	combat_preview_bar_min.hide()
	combat_preview_bar_max.hide()

func _process(_delta):
	if unit:
		if !unit.stats.player and !resource == ActiveSkill.SkillCostResource.HP:
			hide()

		match resource:
			ActiveSkill.SkillCostResource.HP:
				max_value = unit.stats.combat_stats.hp.maximum
				value = unit.stats.combat_stats.hp.current
				self_modulate = Color.GREEN
			ActiveSkill.SkillCostResource.MP:
				max_value = unit.stats.combat_stats.mp.maximum
				value = unit.stats.combat_stats.mp.current
				self_modulate = Color.BLUE

		$Label.text = str(value) + "/" + str(max_value)

		if show_combat_preview and unit.combat_preview_on:
			show_combat_previews()
		else:
			hide_combat_previews()

		if show_cost_preview and unit.cost_previews_on:
			cost_preview_bar.show()
		else:
			cost_preview_bar.hide()

			




