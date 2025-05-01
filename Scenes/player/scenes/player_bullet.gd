extends Area2D

const PLAYER = preload("res://Scenes/player/scenes/player.tscn")
@export var speed = 400
@export var lifetime = 10.00
@export var rotation_change = 0.0
var direction = Vector2.UP
var flipped_direction = Vector2.DOWN
@export var flip_sprite: bool
var Shotgun = false
var flipped = false

func _ready():
	$Timer.start(lifetime)
	
func _process(delta: float) -> void:
	#TODO NEED TO SETUP ROTATION FOR SHOOTING
	if !flipped:
		translate(direction.normalized() * speed * delta)
	else:
		translate(flipped_direction.normalized() * (speed * -1) * delta)
	if flip_sprite == true:
		$Sprite2D.scale.y = -1
	else:
		$Sprite2D.scale.y = 1
	if Shotgun:
		$Timer.start(0.2)
		Shotgun = false

func _on_timer_timeout() -> void:
	queue_free()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("border"):
		queue_free()
		



func _on_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
