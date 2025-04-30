extends Resource
class_name PlayerStats
enum WeaponTypes {Basic = 1 , Shotgun = 2, Laser = 3, MachineGun = 4 }
#Variables that need to be changed for each player ship
@export var Speed: float
@export var Sprite: Texture2D
@export var WeaponCD: float
@export var FlipCD: float
@export var WeaponType: WeaponTypes
