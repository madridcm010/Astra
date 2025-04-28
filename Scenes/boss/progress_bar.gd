extends ProgressBar

func _ready():
	await get_tree().create_timer(0.5).timeout
	Change_HP(10)

func Change_HP(damage: int):
	var tween = create_tween()
	tween.tween_property(self, "value", value - damage, 0.3)
	
