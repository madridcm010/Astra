class_name HubStats
extends Resource

@export var health_level : int
@export var thruster_level : int
@export var attackspeed_level : int
@export var damage_level : int

@export var health_cost : int 
@export var thruster_cost : int
@export var attackspeed_cost : int
@export var damage_cost : int

@export var ship1_cost : int
@export var ship2_cost : int
@export var ship3_cost : int

@export var ship1purchased : bool
@export var ship2purchased : bool
@export var ship3purchased : bool

func reset():
	health_level = 0
	thruster_level = 0
	attackspeed_level = 0
	damage_level = 0

	health_cost = 0 
	thruster_cost = 0
	attackspeed_cost = 0
	damage_cost = 0

	ship1purchased = false
	ship2purchased = true
	ship3purchased = false
