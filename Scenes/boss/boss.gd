extends AnimatedSprite2D
#enum collections for phases of boss and for bullet patterns.
enum patterns { spread = 1 , tracer = 2, box = 3 , circle = 4 }
enum phases { phase1 = 1, phase2 = 2, phase3 = 3 }
@export var hp = 100.0 : set = _set_health
@export var speed = 0.0
@export var phase: phases
@export var bullet_patterns: patterns
@export var _damage = 2 : set = change_hp
@onready var healthbar = $healthbar
@onready var boss_anim = $Boss
signal boss_defeated


func _set_health(value: float):
	if hp<=0:
		boss_defeated.emit()
		await get_tree().create_timer(1).timeout
		_dead()
		await get_tree().create_timer(10).timeout
		queue_free()
	if hp>0:
		hp = value 
		healthbar.hp = hp
		

func change_hp(_damage: float):
	#healthbar.value = hp
	_set_health(hp - _damage)
	
	

func _ready():
	healthbar.init_health(hp)
	_Idle()
	
func _process(delta: float) -> void:
	get_input()

func get_input():
	#for i in range(0, hp + 1):
	if Input.is_action_just_pressed("shoot"):
		#_set_health(hp - _damage)
		
		play("damage")
		change_hp(_damage)
		await get_tree().create_timer(.5).timeout
		_Idle()
		if hp<0:
			change_hp(_damage)
			
			
		
		
func _dead():
	stop()
	play("Death")
	
	
		
		
func _Idle():
	if hp != 0:
		play("Idle")
