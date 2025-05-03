extends CharacterBody2D

@export var stats : Playerstats

#var speed = stats.Speed
var current_rotation :float =  0.0
const rotation_speed = 180
const PLAYER_BULLET = preload("res://Scenes/player/scenes/player_bullet.tscn")
var can_shoot = true
var is_playing = false
@onready var audio_player = $AudioStreamPlayer2D
#var fire_type := stats.WeaponChoice == 1
# signal to be sent level for laser spawns
signal weapon(pos, rot)
#signal spread_weapon(pos,rot)

#function for adjusting player image & collision shape between 0 & 180 degrees 
func playerFlip(rot):
	rot = $PlayerImage.rotation_degrees
	if (rot == 0):
		$PlayerImage.rotation_degrees = 180
		#TODO FIX THIS PLEASE!
		#$PlayerCollision.rotation_degrees = 180
	else:
		$PlayerImage.rotation_degrees = 0
		$PlayerCollision.rotation_degrees = 0

		
#signal function
func _on_boss_defeated():
	can_shoot = false

# Starting values for player cooldowns
var weaponReady : bool = true
var flipReady : bool = true

# function for getting directional and flip input of player
func get_input():
	var input_direction = Input.get_vector("left","right","up", "down")
	velocity = input_direction * stats.Speed
	if Input.is_action_just_pressed("flip") and flipReady:
		playerFlip($PlayerImage.rotation_degrees)
		flipReady = false 
		$FlipCD.start()
		
# constantly running function

func _ready() -> void:
	$PlayerImage.texture = stats.Sprite
func _process(_delta):
	#speed = stats.Speed
	#var speed = stats.Speed
	
	get_input()
	move_and_slide()
	
	# Checks for shoot input of player and checks that the weapon is not on cooldown
	if Input.is_action_pressed("shoot") and weaponReady and can_shoot:
		#comments for bullets
		fire()
		if !is_playing:
			#$AudioStreamPlayer2D.play()
			randomize_pitch_and_play()
			
		
			
			#weapon.emit($WeaponSpawnTop.global_position, 0)
			
		
		weaponReady = false
		$WeaponCD.start()

#Timers for player using resource
	$WeaponCD.wait_time = stats.WeaponCD
	$FlipCD.wait_time = stats.FlipCD
	
# gun functionality
func fire():
	
	if $PlayerImage.rotation_degrees == 0:
		if stats.WeaponChoice == 1 :
			stats.WeaponDamage = 10
			var new_bullet = PLAYER_BULLET.instantiate()
			new_bullet.position = $WeaponSpawnTop1.get_global_position()
			add_sibling(new_bullet)
			
			
		elif stats.WeaponChoice == 2:
			stats.WeaponDamage = 2
			var new_bullet = PLAYER_BULLET.instantiate()
			new_bullet.position = $WeaponSpawnTop1.get_global_position()
			add_sibling(new_bullet)
			var new_bullet2 = PLAYER_BULLET.instantiate()
			new_bullet2.position = $WeaponSpawnTop2.get_global_position()
			add_sibling(new_bullet2)
			var new_bullet3 = PLAYER_BULLET.instantiate()
			new_bullet3.position = $WeaponSpawnTop3.get_global_position()
			add_sibling(new_bullet3)
			
			
		elif stats.WeaponChoice == 4:
			stats.WeaponDamage = 5
			#change the weaponcd time to .15 inside of .tres file
			var new_bullet = PLAYER_BULLET.instantiate()
			new_bullet.position = $WeaponSpawnTop1.get_global_position()
			add_sibling(new_bullet)
			
	if $PlayerImage.rotation_degrees == 180:
		if stats.WeaponChoice == 1:
			stats.WeaponDamage = 10
			var new_bullet = PLAYER_BULLET.instantiate()
			new_bullet.speed *= -1
			new_bullet.flip_sprite == true
			new_bullet.position = $WeaponSpawnBot1.get_global_position()
			add_sibling(new_bullet)
		elif stats.WeaponChoice == 2:
			stats.WeaponDamage = 2
			var new_bullet = PLAYER_BULLET.instantiate()
			new_bullet.speed *= -1
			new_bullet.position = $WeaponSpawnBot1.get_global_position()
			add_sibling(new_bullet)
			var new_bullet2 = PLAYER_BULLET.instantiate()
			new_bullet2.speed *= -1
			new_bullet2.position = $WeaponSpawnBot2.get_global_position()
			add_sibling(new_bullet2)
			var new_bullet3 = PLAYER_BULLET.instantiate()
			new_bullet3.speed *= -1
			new_bullet3.position = $WeaponSpawnBot3.get_global_position()
			add_sibling(new_bullet3)
			
			
		# TODO laser mechanics added here
		elif stats.WeaponChoice == 4:
			stats.WeaponDamage = 5
			#change the weaponcd time to .15 inside of .tres file
			var new_bullet = PLAYER_BULLET.instantiate()
			new_bullet.speed *= -1
			new_bullet.position = $WeaponSpawnBot1.get_global_position()
			add_sibling(new_bullet)
	
func randomize_pitch_and_play():
	var rng = RandomNumberGenerator.new()
	rng.randomize()

	#random pitch and temp
	audio_player.pitch_scale = rng.randf_range(1.5,3)
	audio_player.play()


# signal receiver for ship weapon cooldown timer


func _on_Weapon_CD_timeout() -> void:
	weaponReady = true


# signal receiver for ship flip cooldown timer
func _on_flip_cd_timeout() -> void:
	flipReady = true
