extends ProgressBar

@onready var player_stats = load("res://Resources/Player/player.tres")


func _ready() -> void:
	$".".value = player_stats.Health
