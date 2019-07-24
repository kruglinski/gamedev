extends Node2D

signal drop_sun(pos)

onready var ray = get_node("sprite/RayCast2D")
onready var anim_move = get_node("sprite/anim_move")
onready var sprite = get_node("sprite")
onready var start_timer = get_node("start_timer")

func _ready():
	randomize()
	start_timer.set_wait_time(randf() * 3)
	start_timer.start()

func _on_shot_timer_timeout():
	if ray.is_colliding():
		emit_signal("drop_sun", sprite.get_global_pos())

func _on_start_timer_timeout():
	anim_move.set_speed(sign(rand_range(-1, 1)))
	anim_move.play("move")
	start_timer.queue_free()
