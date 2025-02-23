extends Node2D

var weapon_scene: PackedScene = load("res://Scenes/basic_weapon.tscn")

func _on_player_weapon(pos) -> void:
	var weapon = weapon_scene.instantiate()
	$Weapon.add_child(weapon)
	weapon.position = pos
	print(pos)
