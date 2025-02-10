extends Node2D


func _process(delta: float) -> void:
	translate(Vector2.DOWN * 30 * delta)
	
void set_texture_repeat(TextureRepeat)
	TextureRepeat get_texture_repeat()
