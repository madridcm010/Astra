extends Node2D

@onready var pause_menu = $"Pause Menu"
var paused = false
const ENEMY = preload("res://Scenes/enemy/scenes/enemy.tscn")
const BOSS = preload("res://Scenes/boss/Boss.tscn")
@export var enemystats = load("res://Resources/Enemy/enemy.tres").duplicate()
@export var playerstats = load("res://Resources/Player/player.tres")

var rng = RandomNumberGenerator.new()
@onready var kill_count = 0
@onready var kills_needed = 40
@onready var credits_earned = 100
@onready var credits_total : int

signal send_kills(int)
signal kill_up
# start of pause menu functionality.
func _ready():
	$"Pause Menu".hide()
	send_kills.emit(kills_needed)
	
	
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
	enemy.stats.enemy_spawn_location = 1
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
	boss.playerdamage = playerstats
	boss.position = Vector2(-9,-144)
	add_child(boss)
	$Spawnboss.stop()
	$NorthSpawn.stop()
	$SouthSpawn.stop()
	boss.health_value.connect(change_boss_health)
	$Control/HBoxContainer/ColorRect2/NinePatchRect/LevelProgressBar.visible = false
	$Control/HBoxContainer/ColorRect2/NinePatchRect/Label2.visible = false
	$Control/HBoxContainer/ColorRect2/NinePatchRect/BossHealthBar.visible = true
	$Control/HBoxContainer/ColorRect2/NinePatchRect/BossHealthBar.value = 500
	$Control/HBoxContainer/ColorRect2/NinePatchRect/Label.visible = true
		##TODO start boss music


#REMINDER RETURN TO HUB AFTER BOSS KILL
#get_tree().change_scene_to_packed(Level5)
			

func handle_enemy_kills():
	kill_count += 1
	kill_up.emit()
	playerstats.Credits += 100
	ResourceSaver.save(playerstats, "res://Resources/Player/player.tres")
	if (kill_count >= kills_needed and $Spawnboss.is_stopped()):
			$Spawnboss.start()
		

func _on_spawnboss_timeout() -> void:
	spawn_boss()

	
func change_boss_health(boss_health):
	$Control/HBoxContainer/ColorRect2/NinePatchRect/BossHealthBar.value = boss_health
