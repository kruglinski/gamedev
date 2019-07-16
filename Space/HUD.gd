extends CanvasLayer

var score_label
var shield_bar
var shield_num
var shield_tex_green
var shield_tex_yellow
var shield_tex_red
var message
var message_timer
var pause_popup
var game_over_popup

func _ready():
	score_label = get_node("score")
	shield_bar = get_node("shield_bar")
	shield_num = get_node("shield_num")
	message = get_node("message")
	message_timer = get_node("message_timer")
	pause_popup = get_node("pause_popup")
	game_over_popup = get_node("game_over_popup")

	shield_bar.set_value(global.shield_max)

	shield_tex_green = load("res://art/gui/barHorizontal_green_mid 200.png")
	shield_tex_yellow = load("res://art/gui/barHorizontal_yellow_mid 200.png")
	shield_tex_red = load("res://art/gui/barHorizontal_red_mid 200.png")

	shield_bar.set_progress_texture(shield_tex_green)

func score_update(size):
	global.score += size
	score_label.set_text("%d" % global.score)

func _on_rock_score_update( size ):
	score_update(size)

func _on_enemy_score_update( size ):
	score_update(size)

func _on_player_score_update( size ):
	score_update(size)

func _on_player_shield_level_update( level ):
	if level <= 40:
		shield_bar.set_progress_texture(shield_tex_red)
	elif level <= 70:
		shield_bar.set_progress_texture(shield_tex_yellow)
	else:
		shield_bar.set_progress_texture(shield_tex_green)
	shield_bar.set_value(level)
	shield_num.set_text(str(level))

func show_message(msg, timeout=3):
	message.set_text(msg)
	message.show()
	message_timer.set_wait_time(timeout)
	message_timer.start()

func show_game_over():
	game_over_popup.show()

func _on_message_timer_timeout():
	message.hide()
	message.set_text("")

func _on_Controller_action_pause():
	if game_over_popup.is_visible():
		return

	global.game_pause = not global.game_pause
	get_tree().set_pause(global.game_pause)
	if global.game_pause:
		pause_popup.show()
		AudioServer.set_fx_global_volume_scale(0)
		AudioServer.set_stream_global_volume_scale(0)
	else:
		pause_popup.hide()
		AudioServer.set_fx_global_volume_scale(1)
		AudioServer.set_stream_global_volume_scale(1)

func _on_restart_button_up():
	global.new_game()
