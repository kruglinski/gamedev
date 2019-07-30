extends CanvasLayer

var player

func _on_Canvas_gun_fire():
	if player:
		player.gun_fire()

func _on_Canvas_navi_gun( dir ):
	if player:
		player.navi_gun(dir)

func _on_Canvas_navi_tank( dir ):
	if player:
		player.navi_tank(dir)

func _on_Canvas_stop_tank():
	if player:
		player.stop_tank()
