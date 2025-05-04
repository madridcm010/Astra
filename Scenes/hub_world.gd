extends Node2D

@export var hubstats : HubStats
@onready var pause_menu = $"Pause Menu"
var paused = false
@onready var player_stats = load("res://Resources/Player/player.tres")
#@onready var save_path = load("res://Resources/SaveData.tres")

@onready var Level1 = load("res://Scenes/enemy/scenes/level1.tscn")

@onready var health_image = $HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/HealthVBox/HealthTexture
@onready var attackspeed_image = $HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ASVBox/ASTexture
@onready var thruster_image = $HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ThrusterVBox/ThrusterTexture
@onready var damage_image = $HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/DamageVBox/DamageTexture

@onready var health_cost = (500 * (hubstats.health_level + 1))
@onready var attackspeed_cost = (500 * (hubstats.attackspeed_level + 1))
@onready var thruster_cost = (500 * (hubstats.thruster_level + 1))
@onready var damage_cost = (500 * (hubstats.damage_level + 1))


func _ready():
	$"Pause Menu".hide()
	health_image.texture = health_image.texture.duplicate()
	damage_image.texture = damage_image.texture.duplicate()
	thruster_image.texture = thruster_image.texture.duplicate()
	attackspeed_image.texture = attackspeed_image.texture.duplicate()
	$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect.visible = false
	$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer.visible = false
	$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/ClosedSpacer.visible = true
	$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/OptionsMargin/OptionsVBox/Spacer/VBoxContainer/RichTextLabel.set_text("[center]%s[/center]" % str(player_stats.Credits))
	$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship1 VBox/HBoxContainer/Ship1Buy".set_text(str(hubstats.ship1_cost))
	$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship3 VBox/HBoxContainer/Ship3Buy".set_text(str(hubstats.ship3_cost))
	initialize_info()
	save_stats()
	$AnimationPlayer.play("Fade_In")
	await $AnimationPlayer.animation_finished

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Back") && $"Pause Menu".settings_open == false:
		pause_game()

func pause_game():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
		
	paused = !paused

func _on_pause_menu_resume_game() -> void:
	pause_game()

func _on_damage_button_pressed() -> void:
	if(hubstats.damage_level < 10 and player_stats.Credits >= hubstats.damage_cost):
		$ButtonClick.play()
		player_stats.Credits -= hubstats.damage_cost
		hubstats.damage_level += 1
		damage_image.texture.region.position.x = advance_frame(hubstats.damage_level)
		hubstats.damage_cost = (500 * (hubstats.damage_level + 1))
		player_stats.damage_boost += 1 
		save_stats()
		update_credits()
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/DamageVBox/HBoxContainer/DamageButton.set_text(str(hubstats.damage_cost))
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/DamageVBox/RichTextLabel.set_text("[center]Damage +%d%%[/center]" % int(player_stats.damage_boost*10))
	if(hubstats.damage_level == 10):
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/DamageVBox/HBoxContainer/DamageButton.disabled = true
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/DamageVBox/HBoxContainer/DamageButton.set_text("MAX")


func _on_thruster_button_pressed() -> void:
	if(hubstats.thruster_level < 10 and player_stats.Credits >= hubstats.thruster_cost):
		$ButtonClick.play()
		player_stats.Credits -= hubstats.thruster_cost
		hubstats.thruster_level += 1
		thruster_image.texture.region.position.x = advance_frame(hubstats.thruster_level)
		hubstats.thruster_cost = (500 * (hubstats.thruster_level + 1))
		player_stats.thruster_boost += 1
		save_stats()
		update_credits()
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ThrusterVBox/HBoxContainer/ThrusterButton.set_text(str(hubstats.thruster_cost))
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ThrusterVBox/RichTextLabel.set_text("[center]Thrusters +%d%%[/center]" % int(player_stats.thruster_boost*10))
	if(hubstats.thruster_level == 10):
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ThrusterVBox/HBoxContainer/ThrusterButton.disabled = true
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ThrusterVBox/HBoxContainer/ThrusterButton.set_text("MAX")


func _on_as_button_pressed() -> void:
	if(hubstats.attackspeed_level < 10 and player_stats.Credits >= hubstats.attackspeed_cost):
		$ButtonClick.play()
		player_stats.Credits -= hubstats.attackspeed_cost
		hubstats.attackspeed_level += 1
		attackspeed_image.texture.region.position.x = advance_frame(hubstats.attackspeed_level)
		hubstats.attackspeed_cost = (500 * (hubstats.attackspeed_level + 1))
		player_stats.attackspeed_boost += 1
		save_stats()
		update_credits()
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ASVBox/HBoxContainer/ASButton.set_text(str(hubstats.attackspeed_cost))
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ASVBox/RichTextLabel.set_text("[center]Attack Speed +%d%%[/center]" % int(player_stats.attackspeed_boost*10))
	if(hubstats.attackspeed_level == 10):
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ASVBox/HBoxContainer/ASButton.disabled = true
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ASVBox/HBoxContainer/ASButton.set_text("MAX")


func _on_health_button_pressed() -> void:
	if(hubstats.health_level < 10 and player_stats.Credits >= hubstats.health_cost):
		$ButtonClick.play()
		player_stats.Credits -= hubstats.health_cost
		hubstats.health_level += 1
		health_image.texture.region.position.x = advance_frame(hubstats.health_level)
		hubstats.health_cost = (500 * (hubstats.health_level + 1))
		player_stats.health_boost += 1
		save_stats()
		update_credits()
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/HealthVBox/HBoxContainer/HealthButton.set_text(str(hubstats.health_cost))
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/HealthVBox/RichTextLabel.set_text("[center]Health +%d[/center]" % int(player_stats.health_boost*10))
	if(hubstats.health_level == 10):
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/HealthVBox/HBoxContainer/HealthButton.disabled = true
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/HealthVBox/HBoxContainer/HealthButton.set_text("MAX")

func advance_frame(upgrade_frame : float):
		upgrade_frame = 432 * (upgrade_frame) 
		return upgrade_frame

func initialize_info() -> void:
	health_image.texture.region.position.x = advance_frame(hubstats.health_level)
	attackspeed_image.texture.region.position.x = advance_frame(hubstats.attackspeed_level)
	thruster_image.texture.region.position.x = advance_frame(hubstats.thruster_level)
	damage_image.texture.region.position.x = advance_frame(hubstats.damage_level)
	
	$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/DamageVBox/RichTextLabel.set_text("[center]Damage +%d%%[/center]" % int(player_stats.damage_boost*10))
	$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ThrusterVBox/RichTextLabel.set_text("[center]Thrusters +%d%%[/center]" % int(player_stats.thruster_boost*10))
	$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ASVBox/RichTextLabel.set_text("[center]Attack Speed +%d%%[/center]" % int(player_stats.attackspeed_boost*10))
	$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/HealthVBox/RichTextLabel.set_text("[center]Health +%d[/center]" % int(player_stats.health_boost*10))
	$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/HealthVBox/HBoxContainer/HealthButton.set_text(str(health_cost))
	$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ASVBox/HBoxContainer/ASButton.set_text(str(attackspeed_cost))
	$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ThrusterVBox/HBoxContainer/ThrusterButton.set_text(str(thruster_cost))
	$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/DamageVBox/HBoxContainer/DamageButton.set_text(str(damage_cost))
	
	if (hubstats.ship1purchased == true):
		$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship1 VBox/HBoxContainer/Ship1Buy".set_text("OWNED")
		$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship1 VBox/HBoxContainer/Ship1Buy".disabled = true
	if (hubstats.ship3purchased == true):
		$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship3 VBox/HBoxContainer/Ship3Buy".set_text("OWNED")
		$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship3 VBox/HBoxContainer/Ship3Buy".disabled = true
	if(hubstats.damage_level == 10):
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/DamageVBox/HBoxContainer/DamageButton.disabled = true
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/DamageVBox/HBoxContainer/DamageButton.set_text("MAX")
	if(hubstats.health_level == 10):
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/HealthVBox/HBoxContainer/HealthButton.disabled = true
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/HealthVBox/HBoxContainer/HealthButton.set_text("MAX")
	if(hubstats.attackspeed_level == 10):
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ASVBox/HBoxContainer/ASButton.disabled = true
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ASVBox/HBoxContainer/ASButton.set_text("MAX")
	if(hubstats.thruster_level == 10):
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ThrusterVBox/HBoxContainer/ThrusterButton.disabled = true
		$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer/ThrusterVBox/HBoxContainer/ThrusterButton.set_text("MAX")
	if(hubstats.ship1purchased == true):
		$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship1 VBox/Ship1Button".disabled = false
	else :
		$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship1 VBox/Ship1Button".disabled = true
	if(hubstats.ship3purchased == true):
		$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship3 VBox/Ship3Button".disabled = false
	else:
		$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship3 VBox/Ship3Button".disabled = true
	hubstats.damage_cost = (500 * (hubstats.damage_level + 1))
	hubstats.thruster_cost = (500 * (hubstats.thruster_level + 1))
	hubstats.attackspeed_cost = (500 * (hubstats.attackspeed_level + 1))
	hubstats.health_cost = (500 * (hubstats.health_level + 1))
	
	
	
	
	
func _on_ship_3_buy_pressed() -> void:
	if (player_stats.Credits >= hubstats.ship3_cost):
		$ButtonClick.play()
		player_stats.Credits -= hubstats.ship3_cost
		hubstats.ship3purchased = true
		$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship3 VBox/HBoxContainer/Ship3Buy".set_text("OWNED")
		$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship3 VBox/HBoxContainer/Ship3Buy".disabled = true
		$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship3 VBox/Ship3Button".disabled = false
		save_stats()
		update_credits()

func _on_ship_1_buy_pressed() -> void:
	if (player_stats.Credits >= hubstats.ship1_cost):
		$ButtonClick.play()
		player_stats.Credits -= hubstats.ship1_cost
		hubstats.ship1purchased = true
		$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship1 VBox/HBoxContainer/Ship1Buy".set_text("OWNED")
		$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship1 VBox/HBoxContainer/Ship1Buy".disabled = true
		$"HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Ship1 VBox/Ship1Button".disabled = false
		save_stats()
		update_credits()
	
func save_stats():
	ResourceSaver.save(hubstats, "res://Resources/Hub/HubStats.tres")
	ResourceSaver.save(player_stats, "res://Resources/Player/player.tres")
	#ResourceSaver.save(save_path, "res://Resources/SaveData.tres")
	
func update_credits():
	$HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/OptionsMargin/OptionsVBox/Spacer/VBoxContainer/RichTextLabel.set_text("[center]%s[/center]" % str(player_stats.Credits))


func _on_hangar_button_pressed() -> void:
	$ButtonClick.play()
	var hangar = $HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/NinePatchRect
	var hangarspacer = $HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/ClosedSpacer
	hangar.visible = !hangar.visible
	hangarspacer.visible = !hangarspacer.visible

func _on_upgrade_button_pressed() -> void:
	$ButtonClick.play()
	var upgradepanel = $HolopadControl/HolopadMargin/HolopagBG/HolopadMargin/HolopadSplit/SelectionBG/HangarMargin/VBoxContainer/GridContainer
	upgradepanel.visible = !upgradepanel.visible


func _on_ship_3_button_pressed() -> void:
	if (hubstats.ship3purchased == true):
		$ButtonClick.play()
		#save_path.equipped_ship = load("res://Resources/Player/RedShip.tres") 
		Autoload.current_ship = load("res://Resources/Player/RedShip.tres")
		save_stats()

func _on_ship_2_button_pressed() -> void:
	$ButtonClick.play()
	#save_path.equipped_ship = load("res://Resources/Player/WhiteShip.tres") 
	Autoload.current_ship = load("res://Resources/Player/WhiteShip.tres")
	save_stats()

func _on_ship_1_button_pressed() -> void:
	if (hubstats.ship1purchased == true):
		$ButtonClick.play()
		#save_path.equipped_ship = load("res://Resources/Player/GreenShip.tres") 
		Autoload.current_ship = load("res://Resources/Player/GreenShip.tres")
		save_stats()
	


func _on_send_button_pressed() -> void:
	$AnimationPlayer.play("Fade_Out")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_packed(Level1)
