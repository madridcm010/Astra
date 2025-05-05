extends CharacterBody2D

@export var stats = load("res://Resources/Enemy/enemy.tres").duplicate()
#var sprite = stats.enemy_sprite
#var spread_weapon_scene: PackedScene = load("res://Scenes/spread_weapon.tscn")
const EXPLOSION = preload("res://Scenes/enemy/scenes/explosion.tscn")
const BULLET = preload("res://Scenes/bullet.tscn")
const PLAYER = preload("res://Scenes/player/scenes/player.tscn")
var time = 0
#var speedchar = 100
var direction : Vector2
signal enemy_defeated



func _ready() -> void:
	#sprite loading
	$Texture.scale = Vector2(1.5,1.5)
	print(get_tree().root.get_children()) 
	#$enemyCollision.scale = Vector2(2,2)
	#$enemyArea.scale = Vector2(2,2)
	$Texture.texture = stats.enemy_sprite.pick_random()
	fire()
	var rng := RandomNumberGenerator.new()
	
	
func _process(delta):
	if stats.enemy_spawn_location == 1:
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
	

func fire():
	$Timer.start()
	
 


func _on_timer_timeout() -> void:
	var enemy_bullet = BULLET.instantiate()
	#get_tree().current_scene.add_child(enemy_bullet)
	# Find the actual player node in the scene tree
	#var player = get_node_or_null("./Level1/Player")
	#if player != null:
		#print("Player position: ", player.global_position)
#
	#if player == null:
		#print("player not found")
		#return


	#if player:
		# Calculate direction from enemy to player
	#var direction = 
	if stats.enemy_spawn_location == 1:
		enemy_bullet.direction = Vector2.DOWN
		enemy_bullet.speed *= 1.5
		for i in stats.enemy_num_of_shots:
			enemy_bullet.global_position = position
			enemy_bullet.rotation = direction.angle()
			get_parent().add_child(enemy_bullet)
	if stats.enemy_spawn_location == 2:
		enemy_bullet.direction = Vector2.UP
		enemy_bullet.rotation_change = 95
		#enemy_bullet.min_rotation = 90
		#enemy_bullet.max_rotation = 180	
		enemy_bullet.global_position = position
		#enemy_bullet.rotation = direction.angle()
		get_parent().add_child(enemy_bullet)
