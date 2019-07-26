extends CanvasLayer

signal left_pressed
signal left_released
signal right_pressed
signal right_released
signal action_1_pressed
signal action_1_released
signal action_2_pressed
signal action_2_released

func _ready():
	pass

func _on_buttons_signal_to_perent( sig, arg0, arg1, arg2, arg3, arg4 ):
	emit_signal(sig)
