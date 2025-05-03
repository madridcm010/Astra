extends TextureProgressBar

@onready var player_stats = load("res://Resources/Player/player.tres")

@onready var player_health = player_stats.Health

func _ready() -> void:
	$".".value = player_health
	
