extends Node

# game settings
var game_pause = false
var game_over = false
var score = 0
var level = 0
var game_scene

# player settings
var shield_max = 100
var shield_regen = 10
var player_pos = Vector2(0, 0)

# rocks settings
var rock_textures = {"big": ["res://sheets/sheet.meteorGrey_big1.atex",
						"res://sheets/sheet.meteorGrey_big2.atex",
						"res://sheets/sheet.meteorGrey_big3.atex",
						"res://sheets/sheet.meteorGrey_big4.atex"],
				"med": ["res://sheets/sheet.meteorGrey_med1.atex",
						"res://sheets/sheet.meteorGrey_med2.atex"],
				"sm": ["res://sheets/sheet.meteorGrey_small1.atex",
						"res://sheets/sheet.meteorGrey_small2.atex"],
				"tiny": ["res://sheets/sheet.meteorGrey_tiny1.atex",
						"res://sheets/sheet.meteorGrey_tiny2.atex"]}

var rock_break_pattern = {"big": "med",
						  "med": "sm",
						  "sm": "tiny",
						  "tiny": null}

var rock_damage = {"big": 40,
				   "med": 20,
				   "sm": 15,
				   "tiny": 10}

var rock_points = {"big": 10,
				   "med": 15,
				   "sm": 20,
				   "tiny": 40}

var enemy_textures = ["res://sheets/sheet.ufoBlue.atex",
					  "res://sheets/sheet.ufoGreen.atex",
					  "res://sheets/sheet.ufoRed.atex",
					  "res://sheets/sheet.ufoYellow.atex"]

func _ready():
	var root = get_tree().get_root()
	game_scene = root.get_child(0)

func change_scene(scene_path):
	get_tree().change_scene(scene_path)

func new_game():
	game_pause = false
	game_over = false
	score = 0
	level = 0
	change_scene("res://main.tscn")