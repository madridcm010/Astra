extends Resource
class_name shipstats

enum WeaponTypes {Basic = 1, Shotgun = 2 , laser = 3 , Machinegun = 4 }

@export var Speed : float
@export var Sprite: Texture2D 
@export var WeaponCD: float
@export var WeaponChoice : WeaponTypes
@export var WeaponDamage : float
@export var Health : int
