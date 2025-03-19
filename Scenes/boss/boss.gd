extends AnimatedSprite2D
#enum collections for phases of boss and for bullet patterns.
enum patterns { spread = 1 , tracer = 2, box = 3 , circle = 4 }
enum phases { phase1 = 1, phase2 = 2, phase3 = 3 }
@export var hp = 100.0 : set = _set_health
@export var speed = 0.0
@export var phase: phases
@export var bullet_patterns: patterns
@export var _damage = 0.25 : set = change_hp
@onready var healthbar = $healthbar

func _set_health(value: float):
	hp = value 
	#if hp<=0:
		#_die()
	healthbar.hp = hp

func change_hp(_damage: float):
	#healthbar.value = hp
	_set_health(hp - _damage)
	

func _ready():
	healthbar.init_health(hp)
	
func _process(delta: float) -> void:
	get_input()

func get_input():
	#for i in range(0, hp + 1):
		if Input.is_action_just_pressed("shoot"):
			#_set_health(hp - _damage)
			change_hp(_damage)
		
