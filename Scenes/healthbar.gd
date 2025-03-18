extends ProgressBar


@onready var timer = $Timer
@onready var damage_bar = $damagebar
var _hp = 0
var hp = 0 : set = _set_hp

	

func init_health(_hp):
	hp = _hp
	max_value = hp
	value = hp
	damage_bar.max_value = hp
	damage_bar.value = hp

func _set_hp(new_hp):
	var prev_hp = hp
	hp = min(max_value, new_hp)
	value = hp
	
	
	if hp <=0:
		queue_free()
	if hp < prev_hp:
		timer.start()
		
	else:
		damage_bar.value = hp

func _on_timer_timeout() -> void:
	damage_bar.value = hp
