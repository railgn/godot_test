class_name PassiveSkill
extends Skill

## Current implementation:
## 1. ALLOCATE PASSIVE SKILL
## 2. PASSIVE SKILL GRANTS PERMANENT STATUS EFFECT WITH INFO DEFINED HERE
## 3. THAT PERMANENT STATUS EFFECT EITHER:
    ## A) PERFORMS A PERMANENT STAT CHANGING FUNCTION (E.G. +10 HP, + MAX YOYOS, ETC.)
    ## B) HAS A BATTLE START TRIGGER FOR A NON-PERMANENT THAT WILL PERFORM A STAT CHANGING FUNCTION
        ## (E.G. GAIN AN ATTACK BUFF FOR 3 TURNS ON BATTLE START) 

class PassiveSkillStatusEffectStore:
    var id:= "SE_0"
    var turns_left:= 99
    var does_not_expire:= true
    var permanent_persists_outside_battle:= true

var status_effect_granted:= PassiveSkillStatusEffectStore.new() 

var passive_optional_properties:= {}