extends Area2D
var enemy_scene: PackedScene = load("res://Scenes/enemy/scenes/enemy.tscn")
@export var speed = 1000

# constantly running function
func _process(delta):
		position.y -= speed * delta

# signal receiver to delete spawned laser after despawn timer
func _on_despawn_timeout() -> void:
	queue_free()
	
#func _on_area_entered(area: Area2D) -> void:
	#enemy_scene.
