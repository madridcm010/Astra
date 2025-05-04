extends CharacterBody2D
#enum collections for phases of boss and for bullet patterns.

@export var ship_stats : shipstats
@export var boss_stats : BossStats
@onready var player_stats = load("res://Resources/Player/player.tres")
const SPREAD_WEAPON = preload("res://Scenes/spread_weapon.tscn")
const BULLET = preload("res://Scenes/bullet.tscn")
var hp
var bullet_patterns
var _damage : float = 0.0 #set default 
@onready var boss_anim = $Boss
signal boss_defeated
var is_dead = false
@onready var fire_timer = $Timer

signal health_value(hp : int)


func _set_health(value: float):
	if hp<=0:
		is_dead = true
		$Area2D.disconnect("area_entered" , _on_area_2d_area_entered)
		await get_tree().create_timer(1).timeout
		_dead()
		boss_defeated.emit()
	if is_dead:
		return
	hp = value
		

func change_hp(_damage: float):
	#healthbar.value = hp
	_set_health(hp - _damage)
	
	

func _ready():
	if Autoload.current_ship == null:
		ship_stats = load("res://Resources/Player/WhiteShip.tres")
	else:
		ship_stats = Autoload.current_ship
	_damage = ship_stats.WeaponDamage + (ship_stats.WeaponDamage *(.1 * player_stats.damage_boost))
	hp = boss_stats.hp
	bullet_patterns = boss_stats.patterns
	_set_health(hp)
	#Randomize pattern
	boss_stats.randomize_pattern()
	bullet_patterns = boss_stats.patterns
	fire_timer.start()
	_Idle()
	
		
func _dead():
	$Boss.stop()
	$Boss.play("Death")
	await $Boss/AnimationPlayer.animation_finished
	
	
	
# firing mechanics
func _fire():
	match bullet_patterns:
		boss_stats.Patterns.Circle:
			_fire_circle()
		boss_stats.Patterns.Wave:
			_fire_wave()
		boss_stats.Patterns.Spiral:
			_fire_spiral()
	
func _fire_circle():
	print("firing circle")
	$Boss.play("ranged")
	await $Boss.animation_finished
	var weapon = SPREAD_WEAPON.instantiate()
	weapon.global_position = $Marker2D.global_position
	var bullet = BULLET.instantiate()
	bullet.direction = Vector2.DOWN
	weapon.spawn_rate = .5
	weapon.number_of_bullets = 25
	weapon.bullet_speed = 500
	weapon.bullet_lifetime = 3
	weapon.bullet_rotation_change = 0
	weapon.is_random = false
	weapon.min_rotation = 0
	weapon.max_rotation = 360
	add_child(weapon)
	#await get_tree().create_timer(1).timeout
	$AudioStreamPlayer2D.play()
	$Boss.stop()
	$Boss.play("Idle")
	

func _fire_wave():
	print("firing wave")
	$Boss.play("ranged")
	await $Boss.animation_finished
	var weapon = SPREAD_WEAPON.instantiate()
	weapon.global_position = $Marker2D.global_position
	weapon.spawn_rate = .5
	weapon.number_of_bullets = 10
	weapon.bullet_speed = 500
	weapon.bullet_lifetime = 4
	weapon.bullet_rotation_change = 0
	weapon.is_random = false
	weapon.min_rotation = -25
	weapon.max_rotation = -70
	add_child(weapon)
	#await get_tree().create_timer(1).timeout
	$AudioStreamPlayer2D.play()
	$Boss.stop()
	$Boss.play("Idle")
	

func _fire_spiral():
	print("firing spiral")
	$Boss.play("ranged")
	await $Boss.animation_finished
	var weapon = SPREAD_WEAPON.instantiate()
	weapon.global_position = $Marker2D.global_position
	weapon.spawn_rate = .5
	weapon.number_of_bullets = 12
	weapon.bullet_speed = 500
	weapon.bullet_lifetime = 4
	weapon.bullet_rotation_change = 90
	weapon.is_random = false
	weapon.min_rotation = 30
	weapon.max_rotation = 180
	add_child(weapon)
	#await get_tree().create_timer(1).timeout
	$AudioStreamPlayer2D.play()
	$Boss.stop()
	$Boss.play("Idle")
	
	
#IDLE ANIMATION
func _Idle():
	if hp != 0:
		$Boss.play("Idle")

# boss damage
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet") and !is_dead:
		print(_damage)
		change_hp(_damage)
		health_value.emit(hp)
		await $Boss.animation_finished
		#if !$Boss.is_playing:
			#$Boss.play("damage")
		#await get_tree().create_timer(.5).timeout
		if !is_dead:
			_Idle()


func _on_timer_timeout() -> void:
	if !is_dead:
		boss_stats.randomize_pattern()
		bullet_patterns = boss_stats.patterns
		_fire()
