extends Area2D

const PLAYER = preload("res://Scenes/player/scenes/player.tscn")
@export var speed = 400
@export var lifetime = 10.00
@export var rotation_change = 0.0
@export var direction : Vector2

func _ready():
	$Timer.start(lifetime)
	
func _process(delta: float) -> void:
	if player== false:
		translate(Vector2.UP * speed * delta)
	#if player.rotat:
	#elif $Player/PlayerImage.rotation_degrees == 180:
		#translate(Vector2.DOWN * speed * delta)
		

func _on_timer_timeout() -> void:
	queue_free()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("border"):
		queue_free()
		



func _on_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
