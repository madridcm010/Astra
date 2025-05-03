extends Control


@onready var inputButtonScene = preload("res://Scenes/input_button.tscn")
@onready var actionList = $SettingsBG/ControlsMargin/ControlsVbox/BindingContainer
@onready var resolution_option_button = $SettingsBG/DisplayMargin/DisplayVbox/ResolutionButton

# Variables for key mapping functionality
var is_remapping = false
var action_to_remap = null
var remapping_button = null
var option_open = false

var inputActions : Dictionary = {
	"up" :  "Move Up",
	"down" : "Move Down",
	"left" : "Move Left",
	"right" : "Move Right",
	"flip" : "Flip",
	"shoot" : "Shoot",
	"dodge" : "Dodge",
	
}

var Resolutions: Dictionary = {
	"2560 x 1440" : Vector2i(2560, 1440),
	"1920x1080" : Vector2i(1920, 1080),
	"1280x720" : Vector2i(1280, 720),
}

signal exit_settings

func _ready():
	
	_create_action_list()
	
	$SettingsBG/OptionsMargin.show()
	$SettingsBG/DisplayMargin.hide()
	$SettingsBG/VolumeControl.hide()
	$SettingsBG/ControlsMargin.hide()
	
	add_resolutions()
	
	check_variables()

func _process(_delta: float) -> void:
	
	# Sets text of Master Label to "Master Volume: " + slider value 
	$SettingsBG/VolumeControl/VolumeMargin/VolumeVbox/MasterLabel.set_text(str("Master Volume: ", $SettingsBG/VolumeControl/VolumeMargin/VolumeVbox/MasterSlider.value * 100))
	
	# Sets text of Sound Effects to "Sound Effects: " + slider value 	
	$SettingsBG/VolumeControl/VolumeMargin/VolumeVbox/SFXLabel.set_text(str("Sound Effects: ", $SettingsBG/VolumeControl/VolumeMargin/VolumeVbox/SFXSlider.value * 100))
	
	# Sets text of Music Label to "Music: " + slider value 	
	$SettingsBG/VolumeControl/VolumeMargin/VolumeVbox/MusicLabel.set_text(str("Music: ", $SettingsBG/VolumeControl/VolumeMargin/VolumeVbox/MusicSlider.value * 100))

	if Input.is_action_just_pressed("Back"):
		if option_open:
			reset_menu()
		else:
			exit_settings.emit()

func _on_audio_button_pressed() -> void:
	$ButtonClick.play()
	option_open = true
	
	$SettingsBG/OptionsMargin.hide()
	$SettingsBG/DisplayMargin.hide()
	$SettingsBG/ControlsMargin.hide()
	$SettingsBG/VolumeControl.show()


func _on_display_button_pressed() -> void:
	$ButtonClick.play()
	option_open = true
	
	$SettingsBG/OptionsMargin.hide()
	$SettingsBG/DisplayMargin.show()
	$SettingsBG/VolumeControl.hide()
	$SettingsBG/ControlsMargin.hide()


func _on_controls_button_pressed() -> void:
	$ButtonClick.play()
	option_open = true
	
	$SettingsBG/OptionsMargin.hide()
	$SettingsBG/DisplayMargin.hide()
	$SettingsBG/VolumeControl.hide()
	$SettingsBG/ControlsMargin.show()


func _create_action_list():
	InputMap.load_from_project_settings()
	for item in actionList.get_children():
		item.queue_free()
		
	for action in inputActions:
		var button = inputButtonScene.instantiate()
		var actionLabel = button.find_child("ActionLabel")
		var inputLabel = button.find_child("InputLabel")
		
		actionLabel.text = inputActions[action]
		
		var events = InputMap.action_get_events(action)
		if events.size() > 0:
			inputLabel.text = events[0].as_text().trim_suffix(" (Physical)")
		else:
			inputLabel.text = ""
			
		actionList.add_child(button)
		button.pressed.connect(_on_input_button_pressed.bind(button, action))


func _on_input_button_pressed(button, action):
	if !is_remapping:
		is_remapping = true
		action_to_remap = action
		remapping_button = button
		button.find_child("InputLabel").text = "Press key to bind"


func _input(event):
	if is_remapping:
		if(
			event is InputEventKey ||
			(event is InputEventMouseButton && event.pressed)
		):
			
			#Turn double click into single click
			if event is InputEventMouseButton && event.double_click:
				event.double_click = false
				
			InputMap.action_erase_events(action_to_remap)
			InputMap.action_add_event(action_to_remap, event)
			_update_action_list(remapping_button, event)
			
			is_remapping = false
			action_to_remap = null
			remapping_button = null
			
			accept_event()


func _update_action_list(button, event):
	button.find_child("InputLabel").text = event.as_text().trim_suffix(" (Physical)")


func _on_reset_button_pressed() -> void:
	_create_action_list()


func _on_volume_control_confirm_audio() -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db($SettingsBG/VolumeControl/VolumeMargin/VolumeVbox/MasterSlider.value))
	AudioServer.set_bus_volume_db(1, linear_to_db($SettingsBG/VolumeControl/VolumeMargin/VolumeVbox/SFXSlider.value))
	AudioServer.set_bus_volume_db(2, linear_to_db($SettingsBG/VolumeControl/VolumeMargin/VolumeVbox/MusicSlider.value))


func _on_resolution_button_item_selected(index: int) -> void:
	var ID = resolution_option_button.get_item_text(index)
	get_window().set_size(Resolutions[ID])
	center_window()


func center_window():
	var screenCenter = DisplayServer.screen_get_position() + DisplayServer.screen_get_size()/2
	var windowSize = get_window().get_size_with_decorations()
	get_window().set_position(screenCenter - windowSize /2)


func add_resolutions():
	
	var current_resolution = get_window().get_size()
	var ID = 0
	
	for r in Resolutions:
		resolution_option_button.add_item(r)
		
		if Resolutions[r] == current_resolution:
			resolution_option_button.select(ID)
		
		ID += 1


func _on_fullscreen_checkbox_toggled(toggled_on: bool) -> void:
	if toggled_on:
		get_window().set_mode(Window.MODE_EXCLUSIVE_FULLSCREEN)
	else:
		get_window().set_mode(Window.MODE_WINDOWED)
		center_window()
		
	get_tree().create_timer(.05).timeout.connect(set_resolution_text)
		
func check_variables():
	var _window = get_window()
	var mode = _window.get_mode()


	if mode == Window.MODE_FULLSCREEN:
		$SettingsBG/DisplayMargin/DisplayVbox/FullscreenCheckbox.set_pressed_no_signal(true)


func set_resolution_text():
	var resolution_text = str(get_window().get_size().x)+"x"+str(get_window().get_size().y)
	resolution_option_button.set_text(resolution_text)


func reset_menu():
	
	$SettingsBG/DisplayMargin.hide()
	$SettingsBG/ControlsMargin.hide()
	$SettingsBG/VolumeControl.hide()
	$SettingsBG/OptionsMargin.show()
	
	option_open = false


func _on_title_screen_close_settings() -> void:
	reset_menu()
	
