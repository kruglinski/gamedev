extends Node2D

onready var music = get_node("music")

func play_music(path):
	var ogg = load(path)
	music.add_child(ogg)
	music.set_stream(ogg)
	music.set_loop(true)
	music.play()

func _ready():
	play_music("res://SFX/Chiptune_Adventures_1.ogg")
