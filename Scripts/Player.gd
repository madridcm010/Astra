extends CharacterBody2D

@export var speed = 400
const rotation_speed = 180

# signal to be sent level for laser spawns
signal weapon(pos, rot)
#signal spread_weapon(pos,rot)

#function for adjusting player image & collision shape between 0 & 180 degrees 
func playerFlip(rot):
	rot = $PlayerImage.rotation_degrees
	if (rot == 0):
		$PlayerImage.rotation_degrees = 180
		$PlayerCollision.rotation_degrees = 180
	else:
		$PlayerImage.rotation_degrees = 0
		$PlayerCollision.rotation_degrees = 0

# starting position of Player
func _ready():
	if get_tree().get_current_scene().is_in_group("world"):
		position = Vector2(973, 890)
	elif get_tree().get_current_scene().is_in_group("Boss"):
		position = Vector2(-6,769)

# Starting values for player cooldowns
var weaponReady : bool = true
var flipReady : bool = true

# function for getting directional and flip input of player
func get_input():
	var input_direction = Input.get_vector("left","right","up", "down")
	velocity = input_direction * speed
	if Input.is_action_just_pressed("flip") and flipReady:
		playerFlip($PlayerImage.rotation_degrees)
		flipReady = false 
		$FlipCD.start()
		
# constantly running function
func _process(_delta):
	get_input()
	move_and_slide()
	
	# Checks for shoot input of player and checks that the weapon is not on cooldown
	if Input.is_action_pressed("shoot") and weaponReady:
		if $PlayerImage.rotation_degrees == 0:
			weapon.emit($WeaponSpawnTop.global_position, 0)
		else:
			weapon.emit($WeaponSpawnBot.global_position, 180)
		weaponReady = false
		$WeaponCD.start()

# signal receiver for ship weapon cooldown timer
func _on_Weapon_CD_timeout() -> void:
	weaponReady = true

# signal receiver for ship flip cooldown timer
func _on_flip_cd_timeout() -> void:
	flipReady = true
