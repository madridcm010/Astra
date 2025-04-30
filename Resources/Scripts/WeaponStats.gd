extends Resource
class_name WeaponStats
enum WeaponTypes {Basic = 1 , Shotgun = 2, Laser = 3, MachineGun = 4 }

@export_group("Stats")
@export var Weapon_CD : float
@export var Weapon_type: WeaponTypes
@export var Weapon_Speed: float
@export var Weapon_Damage: float
