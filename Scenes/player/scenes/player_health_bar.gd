extends TextureProgressBar
	

func _on_player_send_health(health: Variant) -> void:
	$".".max_value = health
	$".".value = health


func _on_player_change_hp() -> void:
	$".".value -= 20
