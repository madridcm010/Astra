extends Area2D


@export var speed = 200
@export var lifetime = 10.00
@export var rotation_change = 0.0

func _ready():
	$Timer.start(lifetime)
	
func _process(delta: float) -> void:
	position += Vector2(cos(rotation), -sin(rotation)) * speed * delta
	rotation_degrees += rotation_change * delta

func _on_timer_timeout() -> void:
	queue_free()
