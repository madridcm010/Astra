extends Node2D

var weapon_scene: PackedScene = load("res://Scenes/basic_weapon.tscn")
var enemy_scene: PackedScene = load("res://Scenes/enemy.tscn")



# signal receiver to add basic weapon laser to scene
func _on_player_weapon(pos, rot) -> void:
	var weapon = weapon_scene.instantiate()
	$Weapon.add_child(weapon)
	if (rot == 180):
		weapon.speed *= -1
	weapon.rotation_degrees = rot
	weapon.position = pos

#enemy spawner test
func _on_enemy_spawn_timeout() -> void:
	var enemy = enemy_scene.instantiate()
	add_child(enemy)
	
