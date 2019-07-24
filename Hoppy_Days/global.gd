extends Node

var coin_count
var life_count

func _ready():
	pass

func restart_game():
	coin_count = 0
	life_count = 5
	get_tree().change_scene("res://Scenes/Levels/level_01.tscn")

func game_over():
	get_tree().change_scene("res://Scenes/hud/game_over.tscn")