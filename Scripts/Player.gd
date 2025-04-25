extends CharacterBody2D

@export var speed = 400
const rotation_speed = 180
const PLAYER_BULLET = preload("res://Scenes/player/scenes/player_bullet.tscn")
var can_shoot = true
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
	elif get_tree().get_current_scene().is_in_group("boss_level"):
		position = Vector2(-6,769)
	#connect boss signal
	
	var boss = get_node("res://Scenes/boss/Boss.tscn")
	if boss:
		boss.connect("boss_defeated", _on_boss_defeated)
		
		
#signal function
func _on_boss_defeated():
	
	can_shoot = false

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
	if Input.is_action_pressed("shoot") and weaponReady and can_shoot:
		if $PlayerImage.rotation_degrees == 0:
			var new_bullet = PLAYER_BULLET.instantiate()
			new_bullet.position = $WeaponSpawnTop.get_global_position()
			add_sibling(new_bullet)
			
			#weapon.emit($WeaponSpawnTop.global_position, 0)
			
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
