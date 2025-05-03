extends AnimatedSprite2D



func _ready():
	$AudioStreamPlayer2D.play()
	await animation_finished
	queue_free()
	
	
