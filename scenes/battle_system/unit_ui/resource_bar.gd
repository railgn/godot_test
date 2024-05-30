class_name ResourceBar

var resource: ActiveSkill.SkillCostResource
var current : int
var maximum : int
var preview_min : int
var preview_max : int
var repeats: int

##do parameters snapshot???
## i.e. if you pass in battleunit, will it update automatically if battleunit.hp.current changes
## or do you need to emit a signal from battle unit in the "affect resource" func?

## pretty sure everything below a node will snapshot, but will nodes variables?

func _init(init_resource, init_current, init_maximum):
	pass



