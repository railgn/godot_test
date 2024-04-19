class_name Skill

var id:= "SK_0"
var name:= "default"
var description:= ""
var tooltip:= ""
var hidden:= false
var active:= true

var sprite_ids = {
    'menu' : 0,
    'battle' : 0,
}

var optional_properties:= {
}

func _init(init_id: String, init_name: String, init_active: bool):
    self.id = init_id
    self.name = init_name
    self.active = init_active