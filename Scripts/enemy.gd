extends CharacterBody2D

var speed = 100

func _ready() -> void:
	var rng := RandomNumberGenerator.new()
	
	#start position
	var width = get_viewport().get_visible_rect().size[0]
	var randx = rng.randi_range(0, width)
	
	position = Vector2(randx, 200) 
	
func _process(delta):
	position.y  += speed * delta
	
func _on_enemy_area_area_entered(area: Area2D) -> void:
	queue_free()
