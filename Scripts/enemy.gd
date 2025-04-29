extends CharacterBody2D

@export var stats : Enemystats
#var sprite = stats.enemy_sprite

var time = 0
var speedchar = 100
var spread_weapon_scene: PackedScene = load("res://Scenes/spread_weapon.tscn")

const EXPLOSION = preload("res://Scenes/enemy/scenes/explosion.tscn")




func _ready() -> void:
	#sprite loading
	$Texture.texture = stats.enemy_sprite
	var rng := RandomNumberGenerator.new()
	#var enemy_scene = load("res://Scenes/enemy/scenes/enemy.tscn")
	
	#start position
	#var width = get_viewport().get_visible_rect().size[0]
	#var randx = rng.randi_range(0, width)
	
	#position = Vector2(randx, 200) 
	
func _process(delta):
	translate(Vector2.DOWN * stats.enemy_speed * delta)
	#$enemyArea/AnimatedSprite2D.play("idle_down")
	time += delta
	var movement = cos(time*stats.enemy_frequency)*stats.enemy_amplitude
	position.x += movement * delta
	
	
func _on_enemy_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		var explosion = EXPLOSION.instantiate()
		explosion.global_position = global_position
		add_sibling(explosion)
		queue_free()
		




func die():
	# Stop the enemies movement
	velocity.x = 0
	velocity.y = 0

	# Play a death animation
	$enemyArea/AnimatedSprite2D.stop()
	$enemyArea/AnimatedSprite2D.play("death_down")
	

 
