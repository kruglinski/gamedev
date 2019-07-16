extends KinematicBody2D

var vec = Vector2(0,0)

var touch_index = -1
var touch_pos = Vector2(0, 0)
var touch_release = false

func _ready():
	enable()

func enable():
	set_process_input(true)
	set_process(true)
	set_fixed_process(true)

func disable():
	set_fixed_process(false)
	set_process(false)
	set_process_input(false)

func _input(event):
	if event.type == InputEvent.SCREEN_TOUCH:
		if event.pressed:
			touch_index = event.index
			touch_pos = event.pos

			if get_pos().distance_to(event.pos)>50:
				vec = (touch_pos - get_pos()).normalized()*15
		else:
			touch_release = true
	elif event.type==InputEvent.SCREEN_DRAG and touch_index==event.index:
		if get_pos().distance_to(event.pos)>50:
			touch_pos = event.pos
			vec = (touch_pos - get_pos()).normalized()*15

func _process(delta):
	if get_pos().distance_to(touch_pos)<10:
		vec.x = 0
		vec.y = 0
		if touch_release:
			touch_index = -1
			touch_release = false

func _fixed_process(delta):
	move(vec)
