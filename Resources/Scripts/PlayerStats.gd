extends Resource
class_name Playerstats

@export var Credits : int
@export var health_boost : int
@export var attackspeed_boost : float
@export var thruster_boost : float
@export var damage_boost : float

func reset():
	Credits = 500
	health_boost = 0
	attackspeed_boost = 0
	thruster_boost = 0
	damage_boost = 0
 
