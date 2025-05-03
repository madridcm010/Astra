extends CharacterBody2D
#enum collections for phases of boss and for bullet patterns.
enum patterns { spread = 1 , tracer = 2, box = 3 , circle = 4 }
enum phases { phase1 = 1, phase2 = 2, phase3 = 3 }
@export var playerdamage : Playerstats
@export var hp = 500.0 : set = _set_health
@export var speed = 0.0
@export var phase: phases
@export var bullet_patterns: patterns
var _damage : float = 0.0 #set default 
@onready var healthbar = $healthbar
@onready var boss_anim = $Boss
signal boss_defeated
var is_dead = false



func _set_health(value: float):
	if hp<=0:
		is_dead = true
		$Area2D.disconnect("area_entered" , _on_area_2d_area_entered)
		boss_defeated.emit()
		await get_tree().create_timer(1).timeout
		_dead()
		await get_tree().create_timer(10).timeout
		queue_free()
	if is_dead:
		return
	hp = value 
	healthbar.hp =  hp
		

func change_hp(_damage: float):
	#healthbar.value = hp
	_set_health(hp - _damage)
	
	

func _ready():
	if playerdamage:
		_damage = playerdamage.WeaponDamage
	healthbar.init_health(hp)
	_Idle()
	
#func  _process(delta: float) -> void:
	#get_input()

#func get_input():
	##for i in range(0, hp + 1):
		##_set_health(hp - _damage)
		#
		#play("damage")
		#change_hp(_damage)
		#await get_tree().create_timer(.5).timeout
		#_Idle()
		#if hp<0:
			#change_hp(_damage)
			
			
		
		
func _dead():
	$Boss.stop()
	$Boss.play("Death")
	
	
		
		
func _Idle():
	if hp != 0:
		$Boss.play("Idle")

# boss damage
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet") and !is_dead:
		$Boss.play("damage")
		change_hp(_damage)
		await get_tree().create_timer(.5).timeout
		if !is_dead:
			_Idle()
