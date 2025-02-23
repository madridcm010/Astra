extends CharacterBody2D

@export var speed = 400
const rotation_speed = 180

signal weapon(pos)

#input that player gives
var _direction : Vector2

func _ready():
	position = Vector2(975, 984)

var weaponReady : bool = (true)

func get_input():
	var input_direction = Input.get_vector("left","right","up", "down")
	velocity = input_direction * speed
	if Input.is_action_just_pressed("flip"):
		$PlayerImage.rotation_degrees += 180
		$CollisionShape2D.rotation_degrees += 180
	
func _process(_delta):
	get_input()
	move_and_slide()
	
	# shoot input
	if Input.is_action_pressed("shoot") and weaponReady:
		weapon.emit($WeaponSpawn.global_position)
		weaponReady = false
		$BasicCD.start()


func _on_basic_cd_timeout() -> void:
	weaponReady = true
