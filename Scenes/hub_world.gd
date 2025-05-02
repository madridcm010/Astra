extends Node2D

@export var hub_stats = preload("res://Resources/Hub/HubStats.tres")

@onready var health_image = $HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/HealthVBox/HealthTexture

@onready var attackspeed_image = $HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ASVBox/ASTexture

@onready var thruster_image = $HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ThrusterVBox/ThrusterTexture

@onready var damage_image = $HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/DamageVBox/DamageTexture



@onready var ship1cost = hub_stats.ship1_cost
@onready var ship3cost = hub_stats.ship3_cost

func _ready():
	health_image.texture = health_image.texture.duplicate()
	damage_image.texture = damage_image.texture.duplicate()
	thruster_image.texture = thruster_image.texture.duplicate()
	attackspeed_image.texture = attackspeed_image.texture.duplicate()
	$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship1 VBox/HBoxContainer/Ship1Buy".set_text(str(ship1cost))
	$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship3 VBox/HBoxContainer/Ship3Buy".set_text(str(ship3cost))
	


func _on_damage_button_pressed() -> void:
	if(damage_image.texture.region.position.x < 4320):
		damage_image.texture.region.position.x = advance_frame(damage_image.texture.region.position.x)



func _on_thruster_button_pressed() -> void:
	if(thruster_image.texture.region.position.x < 4320):
		thruster_image.texture.region.position.x = advance_frame(thruster_image.texture.region.position.x)



func _on_as_button_pressed() -> void:
	if(attackspeed_image.texture.region.position.x < 4320):
		attackspeed_image.texture.region.position.x = advance_frame(attackspeed_image.texture.region.position.x)



func _on_health_button_pressed() -> void:
	if(health_image.texture.region.position.x < 4320):
		health_image.texture.region.position.x = advance_frame(health_image.texture.region.position.x)


func advance_frame(upgrade_frame : float):
		upgrade_frame += 432
		return upgrade_frame


func _on_ship_3_buy_pressed() -> void:
	$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship3 VBox/HBoxContainer/Ship3Buy".set_text("OWNED")
	$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship3 VBox/HBoxContainer/Ship3Buy".disabled = true


func _on_ship_1_buy_pressed() -> void:
	$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship1 VBox/HBoxContainer/Ship1Buy".set_text("OWNED")
	$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship1 VBox/HBoxContainer/Ship1Buy".disabled = true
