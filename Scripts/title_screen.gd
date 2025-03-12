extends Node2D

var mainGame = load("res://Scenes/world.tscn")

# Called as soon as scene is ready
func _ready():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	title()
	$AudioStreamPlayer2D.play()

func _process(_delta):
	if Input.is_action_just_pressed("Back"):
		_close_settings_menu()

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

# Function is called on startup, disables all buttons until "Intro" animation finishes playing
func title():	
	$"TitleOptionsControl/TitleOptionsVBox/Continue Game".disabled = true
	$"TitleOptionsControl/TitleOptionsVBox/New Game".disabled = true
	$TitleOptionsControl/TitleOptionsVBox/Settings.disabled = true
	$"TitleOptionsControl/TitleOptionsVBox/Quit Game".disabled = true
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
	$Title.visible = false
	$TitleOptionsControl.visible = false
	$SettingsMenu.visible = true
	
func _close_settings_menu():
	if $SettingsMenu.visible == true:
		$SettingsMenu.visible = false
		$TitleOptionsControl.visible = true
		$Title.visible = true
