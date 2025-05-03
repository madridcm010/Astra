extends Node2D

@onready var pause_menu = $"Pause Menu"
var paused = false
const ENEMY = preload("res://Scenes/enemy/scenes/enemy.tscn")
const BOSS = preload("res://Scenes/boss/Boss.tscn")
@export var enemystats = load("res://Resources/Enemy/enemy.tres").duplicate()

var rng = RandomNumberGenerator.new()
@onready var kill_count = 0
# start of pause menu functionality.
func _ready():
	$"Pause Menu".hide()
	
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Back") && $"Pause Menu".settings_open == false:
		pause_game()
	$Label.set_text(str(kill_count))
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
	enemy.connect("enemy_defeated", handle_enemy_kills)
	#translate(Vector2.DOWN * Enemystats.enemy_speed * delta)
	add_child(enemy)


func _on_south_spawn_timeout() -> void:
	var rand_x = rng.randf_range(500,1400)
	var rand_y = rng.randf_range(1100,1200)
	var enemy = ENEMY.instantiate()
	#if  enemy.kill_count == 1 :
		#$Spawnboss.one_shot()
	enemy.stats.enemy_spawn_location = 2
	enemy.rotation_degrees = 0
	enemy.position = Vector2(rand_x,rand_y)
	enemy.connect("enemy_defeated", handle_enemy_kills)
	add_child(enemy)
# END 

#Start of spawnboss
func spawn_boss():
	get_tree().call_group("enemy", "queue_free")
	var boss = BOSS.instantiate()
	boss.position = Vector2(-9,-144)
	add_child(boss)
	$Spawnboss.stop()
	$NorthSpawn.stop()
	$SouthSpawn.stop()
		#TODO start boss music


#END

func handle_enemy_kills():
	kill_count += 1
	if (kill_count >= 1 and $Spawnboss.is_stopped()):
			$Spawnboss.start()
		

func _on_spawnboss_timeout() -> void:
	spawn_boss()


func _on_health_test_timeout() -> void:
	$Control/HBoxContainer/ColorRect/NinePatchRect/PlayerHealthBar.value -= 5
	print("player health reduced")
