extends Node2D

@export var hub_stats = load("res://Resources/Hub/HubStats.tres").duplicate()

@onready var health_image = $HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/HealthVBox/HealthTexture
@onready var attackspeed_image = $HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ASVBox/ASTexture
@onready var thruster_image = $HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ThrusterVBox/ThrusterTexture
@onready var damage_image = $HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/DamageVBox/DamageTexture


@onready var health_cost = (500 * (hub_stats.health_level + 1))
@onready var attackspeed_cost = (500 * (hub_stats.attackspeed_level + 1))
@onready var thruster_cost = (500 * (hub_stats.thruster_level + 1))
@onready var damage_cost = (500 * (hub_stats.damage_level + 1))


func _ready():

	health_image.texture = health_image.texture.duplicate()
	damage_image.texture = damage_image.texture.duplicate()
	thruster_image.texture = thruster_image.texture.duplicate()
	attackspeed_image.texture = attackspeed_image.texture.duplicate()
	$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship1 VBox/HBoxContainer/Ship1Buy".set_text(str(hub_stats.ship1_cost))
	$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship3 VBox/HBoxContainer/Ship3Buy".set_text(str(hub_stats.ship3_cost))
	$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/HealthVBox/HBoxContainer/HealthButton.set_text(str(hub_stats.health_cost))
	$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ASVBox/HBoxContainer/ASButton.set_text(str(hub_stats.attackspeed_cost))
	$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ThrusterVBox/HBoxContainer/ThrusterButton.set_text(str(hub_stats.thruster_cost))
	$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/DamageVBox/HBoxContainer/DamageButton.set_text(str(hub_stats.damage_cost))
	update_upgrade_images()
#func _process(float) -> void:
	#pass

func _on_damage_button_pressed() -> void:
	if(hub_stats.damage_level < 10):
		hub_stats.damage_level += 1
		damage_image.texture.region.position.x = advance_frame(hub_stats.damage_level)
		hub_stats.damage_cost = (500 * (hub_stats.damage_level + 1))
		save_hub_stats()
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/DamageVBox/HBoxContainer/DamageButton.set_text(str(hub_stats.damage_cost))



func _on_thruster_button_pressed() -> void:
	if(hub_stats.thruster_level < 10):
		hub_stats.thruster_level += 1
		thruster_image.texture.region.position.x = advance_frame(hub_stats.thruster_level)
		hub_stats.thruster_cost = (500 * (hub_stats.damage_level + 1))
		save_hub_stats()
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ThrusterVBox/HBoxContainer/ThrusterButton.set_text(str(hub_stats.thruster_cost))




func _on_as_button_pressed() -> void:
	if(hub_stats.attackspeed_level < 10):
		hub_stats.attackspeed_level += 1
		attackspeed_image.texture.region.position.x = advance_frame(hub_stats.attackspeed_level)
		hub_stats.attackspeed_cost = (500 * (hub_stats.attackspeed_level + 1))
		save_hub_stats()
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ASVBox/HBoxContainer/ASButton.set_text(str(hub_stats.attackspeed_cost))




func _on_health_button_pressed() -> void:
	if(hub_stats.health_level < 10):
		hub_stats.health_level += 1
		health_image.texture.region.position.x = advance_frame(hub_stats.health_level)
		hub_stats.health_cost = (500 * (hub_stats.health_level + 1))
		save_hub_stats()
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/HealthVBox/HBoxContainer/HealthButton.set_text(str(hub_stats.health_cost))



func advance_frame(upgrade_frame : float):
		upgrade_frame = 432 * (upgrade_frame) 
		return upgrade_frame

func update_upgrade_images() -> void:
	health_image.texture.region.position.x = advance_frame(hub_stats.health_level)
	attackspeed_image.texture.region.position.x = advance_frame(hub_stats.attackspeed_level)
	thruster_image.texture.region.position.x = advance_frame(hub_stats.thruster_level)
	damage_image.texture.region.position.x = advance_frame(hub_stats.damage_level)
	if (hub_stats.ship1purchased == true):
		$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship1 VBox/HBoxContainer/Ship1Buy".set_text("OWNED")
		$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship1 VBox/HBoxContainer/Ship1Buy".disabled = true
	if (hub_stats.ship3purchased == true):
		$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship3 VBox/HBoxContainer/Ship3Buy".set_text("OWNED")
		$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship3 VBox/HBoxContainer/Ship3Buy".disabled = true
		
		
		
		
func _on_ship_3_buy_pressed() -> void:
	$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship3 VBox/HBoxContainer/Ship3Buy".set_text("OWNED")
	$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship3 VBox/HBoxContainer/Ship3Buy".disabled = true
	hub_stats.ship3purchased = true
	save_hub_stats()

func _on_ship_1_buy_pressed() -> void:
	$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship1 VBox/HBoxContainer/Ship1Buy".set_text("OWNED")
	$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship1 VBox/HBoxContainer/Ship1Buy".disabled = true
	hub_stats.ship1purchased = true
	save_hub_stats()
	
func save_hub_stats():
	ResourceSaver.save(hub_stats, "res://Resources/Hub/HubStats.tres")
