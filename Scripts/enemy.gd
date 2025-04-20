extends CharacterBody2D

@export  var frequency = 5
@export  var amplitude = 350
var time = 0
var speedchar = 100
var spread_weapon_scene: PackedScene = load("res://Scenes/spread_weapon.tscn")

func _ready() -> void:
	var rng := RandomNumberGenerator.new()
	var enemy_scene = load("res://Scenes/enemy/scenes/enemy.tscn")
	
	#start position
	var width = get_viewport().get_visible_rect().size[0]
	var randx = rng.randi_range(0, width)
	
	position = Vector2(randx, 200) 
	
func _process(delta):
	translate(Vector2.DOWN * speedchar * delta)
	time += delta
	var movement = cos(time*frequency)*amplitude
	position.x += movement * delta
	
	
func _on_enemy_area_area_entered(area: Area2D) -> void:
	die()

@export var attributes: BulletSpawnAttributes:
	set(value):
		attributes = value
	
@export var speed: int = 300
@export var min_rotation: int = 90
@export var max_rotation: int = 360


func die():
	# Stop the enemies movement
	velocity.x = 0
	velocity.y = 0

	# Play a death animation
	
	$AnimationPlayer.play("death_down", 0 , .5 , false)

	# Emit a signal to notify other parts of the game
	emit_signal("enemy_died")

	# Optionally, destroy the character's node
	#queue_free()

 
