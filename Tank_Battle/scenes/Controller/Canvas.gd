extends Node2D

signal navi_tank(dir)
signal stop_tank()
signal navi_gun(dir)
signal gun_fire()

export var pad_color = Color(0, 1, 0, 0.2)

onready var navi_tank_pos = get_node("navi_tank_pos").get_pos()
onready var navi_gun_pos = get_node("navi_gun_pos").get_pos()
onready var gun_fire_pos = get_node("gun_fire_pos").get_pos()

func _ready():
	set_process_input(true)

func _input(event):
	if event.type == InputEvent.SCREEN_TOUCH and not event.pressed:
		if gun_fire_pos.distance_to(event.pos) <= 50:
			emit_signal("gun_fire")

		var distance = navi_tank_pos.distance_to(event.pos)
		if distance > 30 and distance <= 200:
			emit_signal("stop_tank")

		return

	if event.type == InputEvent.SCREEN_DRAG:
		var distance = navi_tank_pos.distance_to(event.pos)
		if distance > 30 and distance <= 200:
			emit_signal("navi_tank", (event.pos-navi_tank_pos).normalized())
			return

		distance = navi_gun_pos.distance_to(event.pos)
		if distance > 30 and distance <= 150:
			emit_signal("navi_gun", (event.pos-navi_gun_pos).normalized())
			return

func _draw():
	draw_circle(navi_tank_pos, 50, pad_color)
	draw_circle(navi_gun_pos, 50, pad_color)
	draw_circle(gun_fire_pos, 50, pad_color)