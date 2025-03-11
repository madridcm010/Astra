extends AnimatedSprite2D

enum patterns { spread = 1 , tracer = 2, box = 3 , circle = 4 }
@export var Health = 0.0
@export var speed = 0.0
@export var phases = []
@export var bullet_patterns: patterns
