extends Control

signal confirmAudio
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VolumeMargin/VolumeVbox/MasterSlider.value = db_to_linear(AudioServer.get_bus_volume_db(0))
	$VolumeMargin/VolumeVbox/SFXSlider.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	$VolumeMargin/VolumeVbox/MusicSlider.value = db_to_linear(AudioServer.get_bus_volume_db(2))


func _on_master_slider_value_changed(_value: float) -> void:
	confirmAudio.emit()


func _on_sfx_slider_value_changed(_value: float) -> void:
	confirmAudio.emit()


func _on_music_slider_value_changed(_value: float) -> void:
	confirmAudio.emit()
