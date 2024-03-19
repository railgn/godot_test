class_name PlayableCharacter

var id := "P_0"
var name:= "default"
var recruitment_level:= 1
var base_class_id:= "BC_0"
var promoted_class_ids: Array[String] = ["PC_0"]

func _init(init_id: String, init_name: String, init_base_class: String):
    id = init_id
    name = init_name
    base_class_id = init_base_class