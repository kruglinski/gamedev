extends Node

var coin_count
var life_count

const scene_game_level_01 = "res://Scenes/Levels/level_01.tscn"
const scene_game_over = "res://Scenes/hud/game_over.tscn"
const music = "res://SFX/Chiptune_Adventures_1.ogg"

func _ready():
	pass

func restart_game():
	coin_count = 0
	life_count = 5
	get_tree().change_scene(scene_game_level_01)

func game_over():
	get_tree().change_scene(scene_game_over)