extends Control

signal resume_game

var settings_open = false

func _ready() -> void:
	$SettingsMenu.hide()

func _on_settings_button_pressed() -> void:
	$ButtonClick.play()
	settings_open = true
	$PauseSprite.hide()
	$PauseBG.hide()
	$SettingsMenu.show()


func _on_quit_button_pressed() -> void:
	$ButtonClick.play()
	await $ButtonClick.finished
	get_tree().quit()


func _on_resume_button_pressed() -> void:
	$ButtonClick.play()
	resume_game.emit()


func _on_settings_menu_exit_settings() -> void:
	settings_open = false
	$SettingsMenu.hide()
	$PauseSprite.show()
	$PauseBG.show()


func _on_save_button_pressed() -> void:
	$ButtonClick.play()
