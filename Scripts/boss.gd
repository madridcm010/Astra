extends AnimatedSprite2D
#enum collections for phases of boss and for bullet patterns.
enum patterns { spread = 1 , tracer = 2, box = 3 , circle = 4 }
enum phases { phase1 = 1, phase2 = 2, phase3 = 3 }
@export var Health = 0.0
@export var speed = 0.0
@export var phase: phases
@export var bullet_patterns: patterns
