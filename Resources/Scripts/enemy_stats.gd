extends Resource
class_name Enemystats
enum spawnlocation {North = 1 , South = 2, }
# Variables used for enemy creation
@export var enemy_sprite : Texture2D

# Stat group for enemy hp and movement variables
@export_group("Stats")
@export var enemy_speed : float
@export var enemy_hp : int
@export var enemy_frequency : int
@export var enemy_amplitude : int
@export var enemy_spawn_location : spawnlocation
@export var enemy_kill_count : float
# Group for various enemy attacks
@export_group("Attacks")
@export var enemy_num_of_shots : float
@export var enemy_damage_of_shots : float
