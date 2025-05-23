extends Node2D

@export var ship_stats : shipstats

@onready var Level1 = load("res://Scenes/enemy/scenes/level1.tscn")
@onready var player_stats = load("res://Resources/Player/player.tres")
@onready var hub_stats = load("res://Resources/Hub/HubStats.tres")
@onready var save_data = load("res://Resources/SaveData.tres")
@onready var hub = load("res://Scenes/hub_world.tscn")

signal close_settings
# Called as soon as scene is ready
func _ready():
	
	if Autoload.current_ship == null:
		ship_stats = load("res://Resources/Player/WhiteShip.tres")
	else:
		ship_stats = Autoload.current_ship
		
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	title()
	$AudioStreamPlayer2D.play()
	$SettingsMenu.hide()
	$Sprite2D.texture = ship_stats.Sprite
	$"Reset Warning".visible = false
	
	if (save_data.GameExists == false):
		$"TitleOptionsControl/TitleOptionsVBox/Continue Game".disabled = true
		print("button disabled")

# Conditional statements to make sure animations finish before next steps take place
func _on_animation_player_animation_finished(animName) -> void:

# Enables menu buttons after "Intro" animation has finished playing
	if animName == "Intro":
		if (save_data.GameExists == true):
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
	get_tree().change_scene_to_packed(Level1)

# Runs Start Game animation, then signals "Start Game" animFinished
func _on_new_game_pressed() -> void:
	if (save_data.GameExists == true):
		$"Reset Warning".visible = true
	
	if (save_data.GameExists == false):
		set_defaults()
		$AnimationPlayer.play("Start Game")
		await $AnimationPlayer.animation_finished
		startGame()
	
	
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
		

func _on_confirm_button_pressed() -> void:
	$"Reset Warning".visible = false
	set_defaults()
	$AnimationPlayer.play("Start Game")
	await $AnimationPlayer.animation_finished
	startGame()
	


func _on_cancel_button_pressed() -> void:
	$"Reset Warning".visible = false
	
func set_defaults():
	player_stats.reset()
	ResourceSaver.save(player_stats, "res://Resources/Player/player.tres")
	hub_stats.reset()
	ResourceSaver.save(hub_stats, "res://Resources/Hub/HubStats.tres")
	save_data.GameExists = true
	ResourceSaver.save(save_data, "res://Resources/SaveData.tres")


func _on_continue_game_pressed() -> void:
	if (save_data.GameExists == true):
		$AnimationPlayer.play("Start Game")
		await $AnimationPlayer.animation_finished
		get_tree().change_scene_to_packed(hub)
