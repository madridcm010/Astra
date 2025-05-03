extends Area2D


@export var speed = 500
@export var lifetime = 10.00
@export var rotation_change = 20.0
var direction : Vector2

func _ready():
	$Timer.start(lifetime)
	
func _process(delta: float) -> void:
	#position += direction * speed * delta
	rotation_degrees += rotation_change * delta
	position += direction *  speed * delta
func _on_timer_timeout() -> void:
	queue_free()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("border"):
		queue_free()
