extends Node2D

var weapon_scene: PackedScene = load("res://Scenes/basic_weapon.tscn")
var spread_weapon_scene: PackedScene = load("res://Scenes/spread_weapon.tscn")
var enemy_scene: PackedScene = load("res://Scenes/enemy/scenes/enemy.tscn")


#func _on_player_spread_weapon(pos, rot) -> void:
	#var spread_weapon = spread_weapon_scene.instantiate()
	#$SpreadWeapon.add_child(spread_weapon)

# signal receiver to add basic weapon laser to scene
#func _on_player_weapon(pos, rot) -> void:
	#var weapon = weapon_scene.instantiate()
	#$#Weapon.add_child(weapon)
	#if (rot == 180):
		#weapon.speed *= -1
	#weapon.rotation_degrees = rot
	#weapon.position = pos

#enemy spawner test
#func _on_enemy_spawn_timeout() -> void:
	#var enemy = enemy_scene.instantiate()
	#add_child(enemy)
	#$enemy/AnimationPlayer.play("Idle_down")
	
	
