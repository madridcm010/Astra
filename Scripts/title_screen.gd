extends Node2D

var mainGame = load("res://Scenes/world.tscn")

signal close_settings
# Called as soon as scene is ready
func _ready():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	title()
	$AudioStreamPlayer2D.play()
	$SettingsMenu.hide()

# Conditional statements to make sure animations finish before next steps take place
func _on_animation_player_animation_finished(animName) -> void:
	
	# Calls startGame function to start the game after "Start Game" animation has finished
	if animName == "Start Game":
		startGame()

# Enables menu buttons after "Intro" animation has finished playing
	if animName == "Intro":
		$"TitleOptionsControl/TitleOptionsVBox/Continue Game".disabled = false
		$"TitleOptionsControl/TitleOptionsVBox/New Game".disabled = false
		$TitleOptionsControl/TitleOptionsVBox/Settings.disabled = false
		$"TitleOptionsControl/TitleOptionsVBox/Quit Game".disabled = false

	if animName == "SettingsOut":
		$SettingsMenu.hide()
		_on_settings_menu_exit_settings()
		

# Function is called on startup, disables all buttons until "Intro" animation finishes playing
func title():	
	$"TitleOptionsControl/TitleOptionsVBox/Continue Game".disabled = true
	$"TitleOptionsControl/TitleOptionsVBox/New Game".disabled = true
	$TitleOptionsControl/TitleOptionsVBox/Settings.disabled = true
	$"TitleOptionsControl/TitleOptionsVBox/Quit Game".disabled = true
	$SettingsMenu.hide()
	$AnimationPlayer.play("Intro")

# Changes scene to Main Game on function call
func startGame():
	get_tree().change_scene_to_packed(mainGame)

# Runs Start Game animation, then signals "Start Game" animFinished
func _on_new_game_pressed() -> void:
	$AnimationPlayer.play("Start Game")
	
# Quits the game on button press
func _on_quit_game_pressed() -> void:
	get_tree().quit()


func _on_settings_pressed() -> void:
	$Title.hide()
	$TitleOptionsControl.hide()
	$SettingsMenu.show()
	$AnimationPlayer.play("SettingsIn")

func _on_settings_menu_exit_settings() -> void:
	if  $SettingsMenu.visible == true:
		$AnimationPlayer.play("SettingsOut")
	else:
		$TitleOptionsControl.show()
		$Title.show()
		close_settings.emit()
