extends Control

export var controller_color = Color(1, 1, 0, 0.2)

signal left_pressed
signal left_released
signal right_pressed
signal right_released
signal action_1_pressed
signal action_1_released
signal action_2_pressed
signal action_2_released

onready var navi_left_pos = get_node("navi_left_pos").get_pos()
onready var navi_right_pos = get_node("navi_right_pos").get_pos()
onready var action_1_pos = get_node("action_1_pos").get_pos()
onready var action_2_pos = get_node("action_2_pos").get_pos()

func _ready():
	set_process_input(true)

func _input(event):
	if event.type != InputEvent.SCREEN_TOUCH:
		return

	var btn_name = ""
	if navi_left_pos.distance_to(event.pos) < 140:
		btn_name = "left"
	elif navi_right_pos.distance_to(event.pos) < 140:
		btn_name = "right"
	elif action_1_pos.distance_to(event.pos) < 140:
		btn_name = "action_1"
	elif action_2_pos.distance_to(event.pos) < 140:
		btn_name = "action_2"
	else:
		return

	var action = "%s_%s" % [btn_name, "pressed" if event.pressed else "released"]
	emit_signal(action)

func _draw():
	draw_circle(navi_left_pos, 100, controller_color)
	draw_circle(navi_right_pos, 100, controller_color)

	draw_circle(action_1_pos, 100, controller_color)
	draw_circle(action_2_pos, 100, controller_color)