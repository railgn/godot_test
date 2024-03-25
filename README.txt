Now:
	Enemy class and dictionary

	Battle Script time?
		1. minimize calculations and loops
		- any time you try to access something, if you loop it'll happen way too many times
		2. it's okay to have a million match statements, (if/else), this is fast

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

	is it worth changing anything to an Array[type]?

	Godot testing framework is in C# guh. Will beef up later:
		# testing frameworks will look something like this
		assert.Equal(result, expected)

		# once test runs no output except a PASS statement will show if everything is working
		# otherwise it will print the exact failing tests and mismatched expect/result
	
Performance considerations -
	Deep copy bad - reevaluate if it becomes a problem
	
