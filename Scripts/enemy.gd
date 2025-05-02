extends CharacterBody2D

@export var stats = load("res://Resources/Enemy/enemy.tres").duplicate()
#var sprite = stats.enemy_sprite
var spread_weapon_scene: PackedScene = load("res://Scenes/spread_weapon.tscn")
const EXPLOSION = preload("res://Scenes/enemy/scenes/explosion.tscn")

var time = 0
#var speedchar = 100
var direction : Vector2
signal enemy_defeated



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
	if stats.enemy_spawn_location == 1:
		#position.y += stats.enemy_speed * delta\
		translate(Vector2.DOWN * stats.enemy_speed * delta)
	if stats.enemy_spawn_location == 2:
		translate(Vector2.UP * stats.enemy_speed * delta)
	time += delta
	var movement = cos(time*stats.enemy_frequency)*stats.enemy_amplitude
	position.x += movement * delta
	
	
func _on_enemy_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		enemy_defeated.emit()
		var explosion = EXPLOSION.instantiate()
		explosion.global_position = global_position
		add_sibling(explosion)
		queue_free()
		




#func die():
	## Stop the enemies movement
	#velocity.x = 0
	#velocity.y = 0
#
	## Play a death animation
	#$enemyArea/AnimatedSprite2D.stop()
	#$enemyArea/AnimatedSprite2D.play("death_down")
	

 
