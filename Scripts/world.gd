extends Node2D

var weapon_scene: PackedScene = load("res://Scenes/basic_weapon.tscn")
var spread_weapon_scene: PackedScene = load("res://Scenes/spread_weapon.tscn")
var enemy_scene: PackedScene = load("res://Scenes/enemy.tscn")
@onready var pause_menu = $"Pause Menu"
var paused = false

func _ready():
	$"Pause Menu".hide()
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Back") && $"Pause Menu".settings_open == false:
		pause_game()
		
#func _on_player_spread_weapon(pos, rot) -> void:
	#var spread_weapon = spread_weapon_scene.instantiate()
	#$SpreadWeapon.add_child(spread_weapon)

# signal receiver to add basic weapon laser to scene
func _on_player_weapon(pos, rot) -> void:
	var weapon = weapon_scene.instantiate()
	$Weapon.add_child(weapon)
	if (rot == 180):
		weapon.speed *= -1
	weapon.rotation_degrees = rot
	weapon.position = pos

#enemy spawner test
#func _on_enemy_spawn_timeout() -> void:
	#var enemy = enemy_scene.instantiate()
	#add_child(enemy)
	
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
