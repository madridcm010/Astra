extends Node2D

@onready var pause_menu = $"Pause Menu"
var paused = false
const ENEMY = preload("res://Scenes/enemy/scenes/enemy.tscn")
@onready var Level5 = load("res://Scenes/enemy/scenes/level5.tscn")
@onready var enemystats = load("res://Resources/Enemy/enemy.tres").duplicate()
@onready var player_stats = load("res://Resources/Player/player.tres")
const HUB_WORLD = preload("res://Scenes/hub_world.tscn")

var rng = RandomNumberGenerator.new()
@onready var kill_count = 0
@onready var kills_needed = 35

signal send_kills(int)
signal kill_up

# start of pause menu functionality.
func _ready():
	$"Pause Menu".hide()
	$AnimationPlayer.play("Fade_In")
	await $AnimationPlayer.animation_finished
	send_kills.emit(kills_needed)
	print("hub scene is: ", hub)
	
	
	
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


# Enemy Spawn North
func _on_north_spawn_timeout() -> void:
	var rand_x = rng.randf_range(500,1400)
	var rand_y = rng.randf_range(-30,-200)
	var enemy = ENEMY.instantiate()
	enemy.stats.enemy_spawn_location = 1
	enemy.rotation_degrees = 180
	enemy.position = Vector2(rand_x,rand_y)
	enemy.connect("enemy_defeated", handle_enemy_kills)
	add_child(enemy)

#Enemy Spawn South
func _on_south_spawn_timeout() -> void:
	var rand_x = rng.randf_range(500,1400)
	var rand_y = rng.randf_range(1100,1200)
	var enemy = ENEMY.instantiate()
	enemy.stats.enemy_spawn_location = 2
	enemy.rotation_degrees = 0
	enemy.position = Vector2(rand_x,rand_y)
	enemy.connect("enemy_defeated", handle_enemy_kills)
	add_child(enemy)



func handle_enemy_kills():
	kill_count += 1
	kill_up.emit()
	player_stats.Credits += 100
	ResourceSaver.save(player_stats, "res://Resources/Player/player.tres")
	if (kill_count >= kills_needed):
		$NorthSpawn.stop()
		$SouthSpawn.stop()
		$Player/PlayerCollision.set_deferred("disabled", true)
		get_tree().call_group("enemy", "queue_free")
		get_tree().call_group("enemy_bullet", "queue_free")
		get_tree().call_group("player_bullet", "queue_free")
		$AnimationPlayer.play("Fade_Out")
		await $AnimationPlayer.animation_finished
		get_tree().change_scene_to_packed(Level5)

func _on_player_death() -> void:
	$NorthSpawn.stop()
	$SouthSpawn.stop()
	get_tree().call_group("enemy", "queue_free")
	get_tree().call_group("enemy_bullet", "queue_free")
	get_tree().call_group("player_bullet", "queue_free")
	$AnimationPlayer.play("Fade_Out")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_packed(HUB_WORLD)
