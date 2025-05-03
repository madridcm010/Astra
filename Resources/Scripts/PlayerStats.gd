extends Resource
class_name Playerstats
#@export_category("Basic" , "Shotgun", "Laser", "MachineGun") var WeaponTypes : String
enum WeaponTypes {Basic = 1, Shotgun = 2 , laser = 3 , Machinegun = 4 }
#enum WeaponDamage {Basic = 10, Shotgun = 5, Machinegun = 3}
#Variables that need to be changed for each player ship
@export var Speed: float
@export var Sprite: Texture2D
@export var WeaponCD: float
@export var FlipCD: float
@export var WeaponType : int
@export var WeaponChoice : WeaponTypes
@export var WeaponDamage : float
@export var Credits : int
@export var Health : int

@export var health_boost : int
@export var attackspeed_boost : float
@export var thruster_boost : float
@export var damage_boost : float

func reset():
	Speed = 300
	Sprite = load("res://Free Assets/Foozle/Main Ship/Main Ship - Engines - Big Pulse Engine.png")
	WeaponCD = 1
	FlipCD = .25
	WeaponChoice = 1
	WeaponDamage = 10
	Credits = 500
	Health = 100
	health_boost = 0
	attackspeed_boost = 0
	thruster_boost = 0
	damage_boost = 0
