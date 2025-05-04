extends TextureProgressBar

func _on_level_1_kill_up() -> void:
	$".".value += 1


func _on_level_1_send_kills(kills_needed: Variant) -> void:
	$".".max_value = kills_needed
	
func _on_level_2_kill_up() -> void:
	$".".value += 1


func _on_level_2_send_kills(kills_needed: Variant) -> void:
	$".".max_value = kills_needed
	
func _on_level_3_kill_up() -> void:
	$".".value += 1


func _on_level_3_send_kills(kills_needed: Variant) -> void:
	$".".max_value = kills_needed
	
func _on_level_4_kill_up() -> void:
	$".".value += 1


func _on_level_4_send_kills(kills_needed: Variant) -> void:
	$".".max_value = kills_needed
	
func _on_level_5_kill_up() -> void:
	$".".value += 1


func _on_level_5_send_kills(kills_needed: Variant) -> void:
	$".".max_value = kills_needed
