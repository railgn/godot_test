Now:
	is it worth changing anything to an Array[type]?

	equipment
		party member code alerts
		equipment class
		equipment dictionary singleton

	Double check if the "-1" in update stats "recalc_base_stats" is correct

	party_member equipment

	party test 
		- change equipment

Later:
	add deep copy of skills? is this needed?
			would be useful when creating similar skills
		same for status effects

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
	SKill tree "TODO" 's
	
