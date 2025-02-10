extends Parallax2D


func _process(delta: float) -> void:
	translate(Vector2.DOWN * 30 * delta)
