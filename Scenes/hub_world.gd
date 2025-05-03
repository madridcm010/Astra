extends Node2D

@export var hub_stats = load("res://Resources/Hub/HubStats.tres").duplicate()
@export var player_stats = load("res://Resources/Player/player.tres").duplicate()

@onready var health_image = $HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/HealthVBox/HealthTexture
@onready var attackspeed_image = $HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ASVBox/ASTexture
@onready var thruster_image = $HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ThrusterVBox/ThrusterTexture
@onready var damage_image = $HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/DamageVBox/DamageTexture


@onready var health_cost = (500 * (hub_stats.health_level + 1))
@onready var attackspeed_cost = (500 * (hub_stats.attackspeed_level + 1))
@onready var thruster_cost = (500 * (hub_stats.thruster_level + 1))
@onready var damage_cost = (500 * (hub_stats.damage_level + 1))

@onready var health_boost = (10 * (hub_stats.health_level))
@onready var attackspeed_boost = (.10 * (hub_stats.attackspeed_level))
@onready var thruster_boost : int = (.10 * (hub_stats.thruster_level))
@onready var damage_boost : int = (.05 * (hub_stats.damage_level))



func _ready():
	
	health_image.texture = health_image.texture.duplicate()
	damage_image.texture = damage_image.texture.duplicate()
	thruster_image.texture = thruster_image.texture.duplicate()
	attackspeed_image.texture = attackspeed_image.texture.duplicate()
	$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/OptionsMargin/OptionsVBox/Spacer/VBoxContainer/RichTextLabel.set_text("[center]%s[/center]" % str(player_stats.Credits))
	$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship1 VBox/HBoxContainer/Ship1Buy".set_text(str(hub_stats.ship1_cost))
	$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship3 VBox/HBoxContainer/Ship3Buy".set_text(str(hub_stats.ship3_cost))
	initialize_info()
	save_stats()

func _on_damage_button_pressed() -> void:
	if(hub_stats.damage_level < 10 and player_stats.Credits >= hub_stats.damage_cost):
		player_stats.Credits -= hub_stats.damage_cost
		hub_stats.damage_level += 1
		damage_image.texture.region.position.x = advance_frame(hub_stats.damage_level)
		hub_stats.damage_cost = (500 * (hub_stats.damage_level + 1))
		player_stats.damage_boost = (.05 * (hub_stats.damage_level))
		save_stats()
		update_credits()
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/DamageVBox/HBoxContainer/DamageButton.set_text(str(hub_stats.damage_cost))
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/DamageVBox/RichTextLabel.set_text("[center]Damage +%d%%[/center]" % int(player_stats.damage_boost * 100))
	if(hub_stats.damage_level == 10):
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/DamageVBox/HBoxContainer/DamageButton.disabled = true
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/DamageVBox/HBoxContainer/DamageButton.set_text("MAX")


func _on_thruster_button_pressed() -> void:
	if(hub_stats.thruster_level < 10 and player_stats.Credits >= hub_stats.thruster_cost):
		player_stats.Credits -= hub_stats.thruster_cost
		hub_stats.thruster_level += 1
		thruster_image.texture.region.position.x = advance_frame(hub_stats.thruster_level)
		hub_stats.thruster_cost = (500 * (hub_stats.thruster_level + 1))
		player_stats.thruster_boost = (.10 * (hub_stats.thruster_level))
		save_stats()
		update_credits()
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ThrusterVBox/HBoxContainer/ThrusterButton.set_text(str(hub_stats.thruster_cost))
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ThrusterVBox/RichTextLabel.set_text("[center]Thrusters +%d%%[/center]" % int(player_stats.thruster_boost * 100))
	if(hub_stats.thruster_level == 10):
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ThrusterVBox/HBoxContainer/ThrusterButton.disabled = true
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ThrusterVBox/HBoxContainer/ThrusterButton.set_text("MAX")


func _on_as_button_pressed() -> void:
	if(hub_stats.attackspeed_level < 10 and player_stats.Credits >= hub_stats.attackspeed_cost):
		player_stats.Credits -= hub_stats.attackspeed_cost
		hub_stats.attackspeed_level += 1
		attackspeed_image.texture.region.position.x = advance_frame(hub_stats.attackspeed_level)
		hub_stats.attackspeed_cost = (500 * (hub_stats.attackspeed_level + 1))
		player_stats.attackspeed_boost = (.10 * (hub_stats.attackspeed_level))
		save_stats()
		update_credits()
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ASVBox/HBoxContainer/ASButton.set_text(str(hub_stats.attackspeed_cost))
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ASVBox/RichTextLabel.set_text("[center]Attack Speed +%d%%[/center]" % int(player_stats.attackspeed_boost * 100))
	if(hub_stats.attackspeed_level == 10):
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ASVBox/HBoxContainer/ASButton.disabled = true
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ASVBox/HBoxContainer/ASButton.set_text("MAX")


func _on_health_button_pressed() -> void:
	if(hub_stats.health_level < 10 and player_stats.Credits >= hub_stats.health_cost):
		player_stats.Credits -= hub_stats.health_cost
		hub_stats.health_level += 1
		health_image.texture.region.position.x = advance_frame(hub_stats.health_level)
		hub_stats.health_cost = (500 * (hub_stats.health_level + 1))
		player_stats.health_boost = (10 * (hub_stats.health_level))
		save_stats()
		update_credits()
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/HealthVBox/HBoxContainer/HealthButton.set_text(str(hub_stats.health_cost))
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/HealthVBox/RichTextLabel.set_text("[center]Health +%d[/center]" % int(player_stats.health_boost))
	if(hub_stats.health_level == 10):
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/HealthVBox/HBoxContainer/HealthButton.disabled = true
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/HealthVBox/HBoxContainer/HealthButton.set_text("MAX")

func advance_frame(upgrade_frame : float):
		upgrade_frame = 432 * (upgrade_frame) 
		return upgrade_frame

func initialize_info() -> void:
	health_image.texture.region.position.x = advance_frame(hub_stats.health_level)
	attackspeed_image.texture.region.position.x = advance_frame(hub_stats.attackspeed_level)
	thruster_image.texture.region.position.x = advance_frame(hub_stats.thruster_level)
	damage_image.texture.region.position.x = advance_frame(hub_stats.damage_level)
	
	$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/HealthVBox/HBoxContainer/HealthButton.set_text(str(health_cost))
	$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ASVBox/HBoxContainer/ASButton.set_text(str(attackspeed_cost))
	$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ThrusterVBox/HBoxContainer/ThrusterButton.set_text(str(thruster_cost))
	$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/DamageVBox/HBoxContainer/DamageButton.set_text(str(damage_cost))
	
	if (hub_stats.ship1purchased == true):
		$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship1 VBox/HBoxContainer/Ship1Buy".set_text("OWNED")
		$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship1 VBox/HBoxContainer/Ship1Buy".disabled = true
	if (hub_stats.ship3purchased == true):
		$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship3 VBox/HBoxContainer/Ship3Buy".set_text("OWNED")
		$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship3 VBox/HBoxContainer/Ship3Buy".disabled = true
	if(hub_stats.damage_level == 10):
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/DamageVBox/HBoxContainer/DamageButton.disabled = true
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/DamageVBox/HBoxContainer/DamageButton.set_text("MAX")
	if(hub_stats.health_level == 10):
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/HealthVBox/HBoxContainer/HealthButton.disabled = true
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/HealthVBox/HBoxContainer/HealthButton.set_text("MAX")
	if(hub_stats.attackspeed_level == 10):
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ASVBox/HBoxContainer/ASButton.disabled = true
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ASVBox/HBoxContainer/ASButton.set_text("MAX")
	if(hub_stats.thruster_level == 10):
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ThrusterVBox/HBoxContainer/ThrusterButton.disabled = true
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ThrusterVBox/HBoxContainer/ThrusterButton.set_text("MAX")
	if(hub_stats.ship1purchased == true):
		$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship1 VBox/Ship1Button".disabled = false
	else :
		$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship1 VBox/Ship1Button".disabled = true
	if(hub_stats.ship3purchased == true):
		$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship3 VBox/Ship3Button".disabled = false
	else:
		$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship3 VBox/Ship3Button".disabled = true
	hub_stats.damage_cost = (500 * (hub_stats.damage_level + 1))
	hub_stats.thruster_cost = (500 * (hub_stats.thruster_level + 1))
	hub_stats.attackspeed_cost = (500 * (hub_stats.attackspeed_level + 1))
	hub_stats.health_cost = (500 * (hub_stats.health_level + 1))
	
	
	
	
	
func _on_ship_3_buy_pressed() -> void:
	if (player_stats.Credits >= hub_stats.ship3_cost):
		player_stats.Credits -= hub_stats.ship3_cost
		$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship3 VBox/HBoxContainer/Ship3Buy".set_text("OWNED")
		$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship3 VBox/HBoxContainer/Ship3Buy".disabled = true
		$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship3 VBox/Ship3Button".disabled = false
		hub_stats.ship3purchased = true
		save_stats()
		update_credits()

func _on_ship_1_buy_pressed() -> void:
	if (player_stats.Credits >= hub_stats.ship1_cost):
		player_stats.Credits -= hub_stats.ship1_cost
		$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship1 VBox/HBoxContainer/Ship1Buy".set_text("OWNED")
		$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship1 VBox/HBoxContainer/Ship1Buy".disabled = true
		$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship1 VBox/Ship1Button".disabled = false
		hub_stats.ship1purchased = true
		save_stats()
		update_credits()
	
func save_stats():
	ResourceSaver.save(hub_stats, "res://Resources/Hub/HubStats.tres")
	ResourceSaver.save(player_stats, "res://Resources/Player/player.tres")
	
func update_credits():
	$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/OptionsMargin/OptionsVBox/Spacer/VBoxContainer/RichTextLabel.set_text("[center]%s[/center]" % str(player_stats.Credits))


func _on_hangar_button_pressed() -> void:
	var hangar = $HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect
	var hangarspacer = $HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/ClosedSpacer
	hangar.visible = !hangar.visible
	hangarspacer.visible = !hangarspacer.visible

func _on_upgrade_button_pressed() -> void:
	var upgradebutton = $HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer
	upgradebutton.visible = !upgradebutton.visible


func _on_ship_3_button_pressed() -> void:
	if (hub_stats.ship1purchased == true):
		player_stats.Sprite = load("res://Free Assets/Foozle/Ship Pack 3/Foozle_2DS0013_Void_EnemyFleet_2/Nairan/Designs - Base/PNGs/Nairan - Bomber - Base.png")
		save_stats()
 

func _on_ship_2_button_pressed() -> void:
	player_stats.Sprite = load("res://Free Assets/Foozle/Main Ship/Main Ship - Engines - Big Pulse Engine.png")
	save_stats()

func _on_ship_1_button_pressed() -> void:
	if (hub_stats.ship3purchased == true):
		player_stats.Sprite = load("res://Free Assets/Foozle/Ship Pack 2/Foozle_2DS0012_Void_EnemyFleet_1/Kla'ed/Base/PNGs/Kla'ed - Frigate - Base.png")
		save_stats()
	
