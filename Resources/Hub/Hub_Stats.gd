class_name HubStats
extends Resource

@export var health_level : int
@export var thruster_level : int
@export var attackspeed_level : int
@export var damage_level : int

@export var health_cost : int = (500 * (health_level + 1))
@export var thruster_cost : int = (500 * (thruster_level + 1))
@export var attackspeed_cost : int = (500 * (attackspeed_level + 1))
@export var damage_cost : int = (500 * (damage_level + 1))

@export var ship1_cost : int
@export var ship2_cost : int
@export var ship3_cost : int

@export var ship1purchased : bool
@export var ship2purchased : bool
@export var ship3purchased : bool
