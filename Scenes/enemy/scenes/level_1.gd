extends Node2D

@onready var pause_menu = $"Pause Menu"
var paused = false
const ENEMY = preload("res://Scenes/enemy/scenes/enemy.tscn")
@export var enemystats = load("res://Resources/Enemy/enemy.tres").duplicate()

var rng = RandomNumberGenerator.new()

# start of pause menu functionality.
func _ready():
	$"Pause Menu".hide()
	#$Player.translate(Vector2.UP * 150)
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Back") && $"Pause Menu".settings_open == false:
		pause_game()
	
func pause_game():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
		
	paused = !paused
	

func _on_pause_menu_resume_game() -> void:
	pause_game()
# end of pause game functionality

#Enemy spawn

func _on_north_spawn_timeout() -> void:
	var rand_x = rng.randf_range(500,1400)
	var rand_y = rng.randf_range(-30,-200)
	var enemy = ENEMY.instantiate()
	enemy.rotation_degrees = 180
	enemy.position = Vector2(rand_x,rand_y)
	#translate(Vector2.DOWN * Enemystats.enemy_speed * delta)
	add_child(enemy)


func _on_south_spawn_timeout() -> void:
	var rand_x = rng.randf_range(500,1400)
	var rand_y = rng.randf_range(1100,1200)
	var enemy = ENEMY.instantiate()
	enemy.stats.enemy_spawn_location = 2
	enemy.rotation_degrees = 0
	enemy.position = Vector2(rand_x,rand_y)
	add_child(enemy)
