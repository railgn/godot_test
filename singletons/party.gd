extends Node

var PARTY:= {}

class PartyMemberStore:
    var id: String
    var party_position: int
    var level: int ##setter that utilizes mapping stat test from
    var stats: Stats
    var skills_store: Skills_Store
    var class_store:= Class_Store.new()
    var equipment_store: Equipment_Store

    func _init():
        ## stats uses party_member stat init function
        # skills_store
        pass

    class Skills_Store:
        class Skill_Store:
            var id: String
            var level: int
        var active_skills = Skill_Store.new()
        var passive_skills = Skill_Store.new()

        func _init():
            ## applies default skills from Party Member Dictionary
            pass

    class Class_Store:
        var id := "C0"
        var promoted:= false
        var skill_tree ##Skill_Tree class. Constructor should take "class_id" as an input
    
    class Equipment_Store:
        ## if nonstandard slots, then Constructor needs to take "class_id"
        var slot