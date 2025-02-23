extends Area2D

@export var speed = 500

func _process(delta):
	position.y -= speed * delta

func _on_despawn_timeout() -> void:
	queue_free()
