extends Node2D

@onready var pause_menu = $"Pause Menu"
var paused = false
# start of pause menu functionality.
func _ready():
	$"Pause Menu".hide()
	#$Player.translate(Vector2.UP * 150)
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Back") && $"Pause Menu".settings_open == false:
		pause_game()
	
func pause_game():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
		
	paused = !paused
	

func _on_pause_menu_resume_game() -> void:
	pause_game()
# end of pause game functionality
