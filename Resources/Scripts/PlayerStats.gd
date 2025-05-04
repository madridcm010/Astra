extends Resource
class_name Playerstats
#@export_category("Basic" , "Shotgun", "Laser", "MachineGun") var WeaponTypes : String
#enum WeaponDamage {Basic = 10, Shotgun = 5, Machinegun = 3}
#Variables that need to be changed for each player ship

@export var Credits : int

@export var health_boost : int
@export var attackspeed_boost : float
@export var thruster_boost : float
@export var damage_boost : float


#func reset():
	#Speed = 300
	#Sprite = preload("res://Free Assets/Foozle/Main Ship/Main_Ship_-_Engines_-_Big_Pulse_Engine.png")
	#WeaponCD = 1
	#FlipCD = .25
	#WeaponChoice = 1
	#WeaponDamage = 10
	#Credits = 500
	#Health = 100
	#health_boost = 0
	#attackspeed_boost = 0
	#thruster_boost = 0
	#damage_boost = 0
	#
#func stat_update():
	#Speed = 300 * ((0.1 * thruster_boost)*100)
	#WeaponCD -= ((.1 * attackspeed_boost) * WeaponCD)
	#WeaponDamage += ((.1 * damage_boost) * WeaponDamage)
	#Health = 100 + (10 * health_boost)  
