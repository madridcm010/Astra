extends Node2D

var planet1 = load("res://Backgrounds/Parallax Test/Planets/Planets Mixed Stacked 2.png")
var planet2 = load("res://Backgrounds/Parallax Test/Planets/Planets Mixed Stacked 3.png")
var planet3 = load("res://Backgrounds/Parallax Test/Planets/Planets Mixed Stacked 4.png")
var planet4 = load("res://Backgrounds/Parallax Test/Planets/Planets Mixed Stacked 5.png")

var neb1 = load("res://Backgrounds/Parallax Test/Nebula/Nebula Funky 1.png")
var neb2 = load("res://Backgrounds/Parallax Test/Nebula/Nebula Funky 2.png")
var neb3 = load("res://Backgrounds/Parallax Test/Nebula/Nebula Funky 3.png")
var neb4 = load("res://Backgrounds/Parallax Test/Nebula/Nebula Funky 4.png")

var dust1 = load("res://Backgrounds/Parallax Test/Dust/Dust Oil 1.png")
var dust2 = load("res://Backgrounds/Parallax Test/Dust/Dust Oil 3.png")
var dust3 = load("res://Backgrounds/Parallax Test/Dust/Dust Oil 4.png")

var star1 = load("res://Backgrounds/Parallax Test/Stars/Stars Oil 1.png")
var star2 = load("res://Backgrounds/Parallax Test/Stars/Stars Oil 2.png")
var star3 = load("res://Backgrounds/Parallax Test/Stars/Stars Oil 3.png")

var planet_list = [planet1, planet2, planet3, planet4]

var nebula_list = [neb1, neb2, neb3, neb4]

var dust_list = [dust1, dust2, dust3]

var star_list = [star1, star2, star3]

func _ready() -> void:
	$NebulaParallax/NebullaSprite.texture = nebula_list.pick_random()
	
	$StarsParallax/StarsSprite.texture = star_list.pick_random()
	
	$DustParallax/DustSprite.texture = dust_list.pick_random()
	
	$PlanetParallax/PlanetSprite.texture = planet_list.pick_random()
	
