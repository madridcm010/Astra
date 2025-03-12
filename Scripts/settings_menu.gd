extends Control


@onready var inputButtonScene = preload("res://Scenes/input_button.tscn")
@onready var actionList = $SettingsBG/ControlsMargin/ControlsVbox/BindingContainer

# Variables for key mapping functionality
var is_remapping = false
var action_to_remap = null
var remapping_button = null

# Variable pointing to master audio bus
var masterBus = AudioServer.get_bus_index("Master")

var inputActions = {
	"up" :  "Move Up",
	"down" : "Move Down",
	"left" : "Move Left",
	"right" : "Move Right",
	"flip" : "Flip",
	"shoot" : "Shoot",
	"dodge" : "Dodge",
	
}
func _ready():
	_create_action_list()
	
	$SettingsBG/OptionsMargin.visible = true
	$SettingsBG/OptionsMargin.set_process(true)
	$SettingsBG/DisplayMargin.visible = false
	$SettingsBG/DisplayMargin.set_process(false)
	$SettingsBG/VolumeMargin.visible = false
	$SettingsBG/VolumeMargin.set_process(false)
	$SettingsBG/ControlsMargin.visible = false
	$SettingsBG/ControlsMargin.set_process(false)

func _process(delta: float) -> void:
	
	# Sets text of Master Label to "Master Volume: " + slider value 
	$SettingsBG/VolumeMargin/VolumeVbox/MasterLabel.set_text(str("Master Volume: ", $SettingsBG/VolumeMargin/VolumeVbox/MasterSlider.value))
	
	# Sets text of Sound Effects to "Sound Effects: " + slider value 	
	$SettingsBG/VolumeMargin/VolumeVbox/SFXLabel.set_text(str("Sound Effects: ", $SettingsBG/VolumeMargin/VolumeVbox/SFXSlider.value))
	
	# Sets text of Music Label to "Music: " + slider value 	
	$SettingsBG/VolumeMargin/VolumeVbox/MusicLabel.set_text(str("Music: ", $SettingsBG/VolumeMargin/VolumeVbox/MusicSlider.value))


func _on_audio_button_pressed() -> void:
	$SettingsBG/OptionsMargin.visible = false
	$SettingsBG/OptionsMargin.set_process(false)
	$SettingsBG/DisplayMargin.visible = false
	$SettingsBG/DisplayMargin.set_process(false)
	$SettingsBG/VolumeMargin.visible = true
	$SettingsBG/VolumeMargin.set_process(true)
	$SettingsBG/ControlsMargin.visible = false
	$SettingsBG/ControlsMargin.set_process(false)


func _on_display_button_pressed() -> void:
	$SettingsBG/OptionsMargin.visible = false
	$SettingsBG/OptionsMargin.set_process(false)
	$SettingsBG/DisplayMargin.visible = true
	$SettingsBG/DisplayMargin.set_process(true)
	$SettingsBG/VolumeMargin.visible = false
	$SettingsBG/VolumeMargin.set_process(false)
	$SettingsBG/ControlsMargin.visible = false
	$SettingsBG/ControlsMargin.set_process(false)

func _on_controls_button_pressed() -> void:
	$SettingsBG/OptionsMargin.visible = false
	$SettingsBG/OptionsMargin.set_process(false)
	$SettingsBG/DisplayMargin.visible = false
	$SettingsBG/DisplayMargin.set_process(false)
	$SettingsBG/VolumeMargin.visible = false
	$SettingsBG/VolumeMargin.set_process(false)
	$SettingsBG/ControlsMargin.visible = true
	$SettingsBG/ControlsMargin.set_process(true)
	

	
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


func _on_master_slider_value_changed(value) -> void:
	AudioServer.set_bus_volume_db(masterBus, value)
