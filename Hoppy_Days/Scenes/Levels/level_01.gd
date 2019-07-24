extends Node2D

onready var music = get_node("music")
onready var player = get_node("player")
onready var game_over_timer = get_node("game_over_timer")
onready var enemies = get_node("enemies")

var lighting_factory = preload("res://Scenes/enemies/lighting.tscn")
var sun_factory = preload("res://Scenes/enemies/sun_mini.tscn")

func play_music(path):
	var ogg = load(path)
	music.add_child(ogg)
	music.set_stream(ogg)
	music.set_loop(true)
	music.play()

func _ready():
	player.connect("player_death", self, "_on_player_player_death")
	game_over_timer.connect("timeout", self, "_on_game_over_timeout")

	play_music(global.music)

func _on_game_over_timeout():
	global.game_over()

func _on_player_player_death():
	game_over_timer.start()

func _on_cloud_drop_lighting( pos ):
	var ice = lighting_factory.instance()
	ice.ice = true
	enemies.add_child(ice)
	ice.set_pos(pos)

func _on_sun_drop_sun( pos ):
	var sun = sun_factory.instance()
	enemies.add_child(sun)
	sun.set_pos(pos)
