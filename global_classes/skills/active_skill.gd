class_name ActiveSkill
extends Skill

class Target:
    enum TargetType{
        NONE,
        SELF,
        ALLY,
        ENEMY,
        ANY,
        ALL,
    }

    enum TargetSide{
        NONE,
        SAME,
        OPPOSITE,
        BOTH,
    }

    ## 2 or more targets allows for attacks that repeat on different targets
    ## Player: game would let them choose two targets
    ## Enemy: targeting function would run twice 
    enum TargetNumber{
        NONE,
        ONE,
        TWO, # add three later. only two for now
        ADJACENT, #splash damage
        ALL,
    }

    var type:= TargetType.NONE
    var side:= TargetSide.NONE
    var number:= TargetNumber.NONE

class Magnitude:
    var damage: Callable = func(_skill_level: int, _user: Stats, _target: Stats, _damage_type: DamangeType) -> int: return 0
    var splash_damage: Callable = func(_skill_level: int, _user: Stats, _target: Stats, _damage_type: DamangeType) -> int: return 0
    var healing: Callable = func(_skill_level: int, _user: Stats, _target: Stats) -> int: return 0

class Cost:
    var resource:= SkillCostResource.NONE
    # think about: if used on bleeding target, refunds cost (cant really do "no cost" cause you would have to select target first)
    var amount: Callable = func(skill_level: int, resource:SkillCostResource, user: Stats) -> int: return 0

enum SkillType {
    NONE,
    DAMAGE,
    RECOVERY,
    STATUS,
    SPAWN,
}

enum DamangeType {
    NONE,
    PHYSICAL,
    MAGICAL,
}

enum SkillCostResource {
    NONE,
    HP,
    MP,
    ENERGY,
    ## OTHER
    YOYO,
    POWER_CHARGE,
}

var usable_outside_battle:= false

var mirror:= false
var mirror_cast:= false
var type:= SkillType.NONE
var target:= Target.new()

var damage_type:= DamangeType.NONE
var magnitude:= Magnitude.new()
var cost:= Cost.new()



enum PrerequisitesEnum {
    STATUS_EFFECT,
    SKILL,
    POWER_CHARGE,
    YOYO
}

var prerequisites:= {
    ## examples - {} i.e. none, {status_effect: "SE_5"} OR {skill: "SK_15"}
    ## Battle System would loop through all keys and apply a switch statement
}




var active_optional_properties:= {
    ## - Guaranteed Crit
    ## - Crit Chance/Damage Multiplier
    ## - Accuracy Multiplier
    ## - Base Stat Change
    ##     - e.g. "HP up" stat
    ##     - these stats would be applied out of battle to 
    ##	   - Need to evaluate if this is even needed vs. just keeping permanent status effects how they are currently implemented
    ## - Status Effect on User
    ##     - % chance
    ##     - Status Effect ID
    ##     - Turn Duration
    ## - Stat Effect on target
    ##     - % chance
    ##     - Status Effect ID
    ##     - Turn Duration
    ## - Special animation/particle effect ID
    ## - Cannot Miss
    ## - On_Kill_ID
    ## - Revive Target
    ## - Repeats
    ##     - Repeats would occur on the same target
    ## - Spawn ID
}