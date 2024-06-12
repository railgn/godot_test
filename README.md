Now:
	status effect logic:
		-spawn
		-turn start
		-turn end
		-death
		-end of battle (player only)

	end of turn
		sending units into mirror

	mirror break
		moving everyone back
		dont update "mirror" bool on units until end of turn

	enemy AI	
	
	





	what about skill previews for secondary effects (on user, not target)
		- life steal
		- attack + buff user?

	Main Menu
		Options
			Resolution
			Volume
		Load Game
		New Game
			Choice of 3 Locations
				Shop
					Purchase -> Select Party Member
						Menu option to proceed to next location choice
				Battle
					Reward
				Elite
					Elite Reward
			Repeats x3

			Boss Location
			
			End
		


	rewards
	Generating locations randomly
	health bar UI
	Use groups instead of "GetUnits" functions.
		cant specify type of get_units_in_group function
		unless you pass gettree() as a parameter into the "GetUnits" function

	Rewards and Options should be singletons
		- Options.playback_speed for animation nodes
		- save data nodes
			- save node as?
				- on new game, use save as default node
			- save node dictionary as json
				- ready function loads json as dictionary

	Save data:

		Look into a save data builder

		Relics
		Items (gold)
		location
		time played
		Rewards (rewards unlocked, also need a rewards singleton for compiling all available rewards (maybe on run start, game compiles all skills/equipment that the current party can use))
			All rewards dictionary:
				- id
				- price
				- weighting/rarity
				- category (skill, equip, etc.)
				- restriction (character: id, or class : id, or equip slot: id)
			alternative is to store all rewards in the class/character class
				then cross check this against rewards unlocked in savedata to get the possible rewards for the current run
				storage on the character should group skills of the same "branch" together (like a skill tree)

	Options:
		Resolution
		Volume
		Fullscreen

	try dialogue plugin
	
	Check phone notes (5/8)


	generate map using random.seed as the rng
		seed generated on save data creation


	1) process_skill
		add some self healing skills with hp skill costs to test 		
			preview interaction of healing + cost
			and self damage skills with hp cost just for fun


	Battle Script time?

		Make the cycle be a function of player count



		1. minimize calculations and loops
		- any time you try to access something, if you loop it'll happen way too many times
		2. it's okay to have a million match statements, (if/else), this is fast


	end of battle:
		save result info back to save_data (i.e. the party auto load)		

Later:
	## beef up class constructors and builtin functions	
		examples 
			ActiveSkill.add_optional_prop(prop: Enum, value)
			more parameters in init
			utilize defaults

			Utilize inheretance when possible in the Dictionary function:
			i.e.
				var effect = Poison.new()
				effect.on_damage_taken = func()
				add_effect(SE_4, effect)

		Dictionary "add" function should be add("id", class instance)

		
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
	Use of process() functions in UI instead of setter signals to only run when the parameter changes
	
