extends Node2D
@export var bullet_scene: PackedScene
@export var min_rotation = 0
@export var max_rotation = 360
@export var number_of_bullets = 8
@export var is_random = false
@export var is_parent = false
@export var is_manual = false
@export var spawn_rate = 0.4
@export var bullet_speed = 5
@export var bullet_lifetime = 10.00
@export var bullet_rotation_change = 0.0


var rotations = []
@export var log_to_console = true

func _ready():
	$Timer.wait_time = spawn_rate
	$Timer.start()
	
func random_rotations():
	rotations = []
	for _i in range(0, number_of_bullets):
		rotations.append(randf_range(min_rotation, max_rotation))

func distributed_rotations():
	rotations = []
	for i in range(0,number_of_bullets):
		var fraction = float(i) / float(number_of_bullets)
		var difference = max_rotation - min_rotation
		rotations.append((fraction * difference) + max_rotation)

func spawn_bullets():
	if(is_random):
		random_rotations()
	else:
		distributed_rotations()
	
	var spawned_bullets = []
	for i in range(0,number_of_bullets):
		#instancing
		var bullet = bullet_scene.instantiate()
		
		spawned_bullets.append(bullet)
		
		#parenting
		if(is_parent):
			add_child(spawned_bullets[i])
		else:
			get_node("/root").add_child(spawned_bullets[i])
		
		
		#fields
		spawned_bullets[i].rotation_degrees = rotations[i]
		spawned_bullets[i].speed = bullet_speed
		spawned_bullets[i].global_position = global_position
		spawned_bullets[i].lifetime = bullet_lifetime
		spawned_bullets[i].rotation_change = bullet_rotation_change
		

func _on_timer_timeout() -> void:
	if(!is_manual):
		spawn_bullets()
		
	if(log_to_console):
		print("spawned bullets!")



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("border"):
		queue_free()
