extends Node2D

export var controller_color = Color(1, 1, 1, 0.1)

signal navi_pressed(dir)
signal navi_rotated(angle)
signal navi_released()
signal action_1_pressed()
signal action_2_pressed()
signal action_pause()

var view_rect
var view_size
var navi_center = Vector2(0, 0)
var navi_end = Vector2(0, 0)

func _ready():
	view_rect = get_viewport_rect()
	view_size = view_rect.size/2
	set_process_input(true)

func _handle_left_touch(event):
	if event.pressed:
		navi_center = event.pos
		navi_end = event.pos
	else:
		navi_center.x = 0
		navi_center.y = 0
		navi_end.x = 0
		navi_end.y = 0
		emit_signal("navi_released")

func _handle_right_touch(event):
	if event.pressed:
		return

	emit_signal("action_1_pressed")

func _handle_left_drag(event):
	var dir = (event.pos - navi_center).normalized()
	var delta = (event.pos - navi_center).length()
	if delta > 150:
		navi_center = event.pos - dir * 150
	elif delta > 100:
		emit_signal("navi_pressed", dir)
	else:
		emit_signal("navi_released")
	emit_signal("navi_rotated", navi_center.angle_to_point(event.pos))
	navi_end = event.pos

func _input(event):
	if global.game_over:
		return

	if event.type == InputEvent.KEY and event.is_pressed() and event.scancode == KEY_SPACE:
		emit_signal("action_pause")
		return

	if event.type == InputEvent.SCREEN_TOUCH and event.pressed and global.game_pause:
		emit_signal("action_pause")
		return

	if event.type == InputEvent.SCREEN_TOUCH:
		if event.pos.x <= view_size.x:
			_handle_left_touch(event)
		else:
			_handle_right_touch(event)
	elif event.type == InputEvent.SCREEN_DRAG:
		if event.pos.x <= view_size.x:
			_handle_left_drag(event)
	else:
		return

	update()

func _draw():
	if navi_center.x != 0:
		draw_circle(navi_center, 150, controller_color)
		draw_circle(navi_center, 100, controller_color)

	if navi_end.x != 0:
		draw_circle(navi_end, 25, controller_color)
