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


func _on_VisibilityNotifier2D_exit_viewport( viewport ):
	var pos = get_node("player").get_pos()
	if pos.y > 0:
		get_node("player").hurt()
		get_node("player/Timer").start()

func _on_Timer_timeout():
	get_tree().change_scene("res://Scenes/hud/game_over.tscn")
