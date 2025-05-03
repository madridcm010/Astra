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
