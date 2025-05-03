extends Resource
class_name BossStats

enum Patterns {Circle =1 , Wave = 2, Spiral = 3, Melee = 4 }
@export_group("Stats")
@export var hp : float
@export var patterns : Patterns = Patterns.Circle


func randomize_pattern():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	#patterns = rng.randi_range(1,4)
	var value = rng.randi_range(1,4)
	print("Random pattern selected:", value)
	patterns = value
