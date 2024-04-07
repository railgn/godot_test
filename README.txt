Now:
	add visuals to unit nodes (take ids and assign sprite from a Dictionary)

	Battle Script time?
		1. minimize calculations and loops
		- any time you try to access something, if you loop it'll happen way too many times
		2. it's okay to have a million match statements, (if/else), this is fast

Battle System notes:

	BattleSystem: Class vs. function?

	Unit nodes just house data
		arent taking actions themselves
		unit nodes would have visual logic on them:
			1) static checks based on properties 
				e.g. flip horizontal when mirror bool is true
			2) animations corresponding to actions
				e.g. animation of using a move
					- "unit.yield(action(), "completed")
					- use yield instead of timer timeouts

	Turn order
		would like this to be an Array
		stores node references
		clears as units take action
		once empty, runs end of turn logic

	Encounters
		- Inputs
			- Player Constructor
				- Input: SaveData
				- Output: list of player nodes
			- Encounter Data
				- List of Enemies Constructors
					- Creates Enemy nodes
			- BattleSystem ID to load
			- Environmental/Visual Templates to load from
				- default based on SaveData's location
			- Battle End Conditions or Parameters?
				- Maybe these could be handled by different versions of Battle System
				- Battle Start can be handled by Scripted AI overrides on turn 0
			- Flag triggers on battle completion?
			- runs battle system with these parameters

	Scene tree:
		BattleSystem (root)
			Players
				Real
					P1
					P2
					P3
					P4
				Mirror
			Enemy
				Real
					
					E2
				Mirror
					E1_M
					E2_M

	end of battle:
		save result info back to save_data (i.e. the party auto load)

	Cons:
		- Two sources of truth
			1) save data
			2) battle system child nodes
			Okay? since they arent being used at the same time. clear hand off at start and end of battle between the two
		

Later:
	## beef up class init functions	
		should have parameters for each property on class
		utilize defaults
		when calling, find a way to specificy which parameter we are trying to set:
			add_effect("SE_4", "poison", effect_on_count_down = func())

		Other option is to utilize inheretance when creating skills in the Dictionary function:
		i.e.
			var effect = Poison.new()
			effect.on_damage_taken = func()
			add_effect(SE_4, effect)
		
	Conditional stat changing status effects? i.e. gain 50% attack when hp is below 50%?
		Can probably implement scaling effects with current framework
			i.e. gain 1% attack for each 1% missing HP

	Skill Level Scalars (for both cost and damage/healing magnitude)
		add a default for 0 and invalid = 1
		evaluate over the max = 2

		Max10(level: int) -> float: 
			switch level
				1: 1.0
				2: 1.05
				3: 1.1
				4: 1.15
				5: 1.5
				...
				10: 2
		Max5(level: int) -> float: 
			switch level
				1: 1.0
				2: 1.15
				3: 1.3
				4: 1.45
				5: 2.0
		etc.

	targetting functions
	Skill tree "TODO" 's

	Scripted AI + dialogue
	Enemy overrides in "enemy_unit.gd"

	is it worth changing anything to an Array[type]?

	Godot testing framework is in C# guh. Will beef up later:
		# testing frameworks will look something like this
		assert.Equal(result, expected)

		# once test runs no output except a PASS statement will show if everything is working
		# otherwise it will print the exact failing tests and mismatched expect/result
	
	Resource node type??????
		doesnt allow for ready func
		doesnt add to scene tree (cant auto load)


Performance considerations -
	Deep copy bad - reevaluate if it becomes a problem
	
