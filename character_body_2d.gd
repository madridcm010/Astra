extends CharacterBody2D

@export var speed = 400
const rotation_speed = 90

#input that player gives

var _direction : Vector2
func _move(direction : Vector2):
	_direction = direction
	
func get_input():
	var input_direction = Input.get_vector("left","right","up", "down")
	velocity = input_direction * speed

func _physics_process(_delta):
	if Input.is_action_just_pressed("flip"):
		$Sprite2D.rotation_degrees += 180
		$CollisionShape2D.rotation_degrees += 180
	get_input()
	move_and_slide()
