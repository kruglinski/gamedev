extends Node2D

onready var music = get_node("music")
onready var player = get_node("player")
onready var game_over_timer = get_node("game_over_timer")

func play_music(path):
	var ogg = load(path)
	music.add_child(ogg)
	music.set_stream(ogg)
	music.set_loop(true)
	music.play()

func _ready():
	player.connect("player_death", self, "_on_player_player_death")
	game_over_timer.connect("timeout", self, "_on_game_over_timeout")

	play_music("res://SFX/Chiptune_Adventures_1.ogg")

func _on_game_over_timeout():
	global.game_over()

func _on_player_player_death():
	game_over_timer.start()
