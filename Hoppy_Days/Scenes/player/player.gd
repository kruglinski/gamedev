extends KinematicBody2D

const ACCEL = 1500
const MAX_SPEED = 10
const FRICTION = -500
const GRAVITY = 40
const MAX_JUMP = -25
const MIN_JUMP = -17

onready var anim_sprite = get_node("anim_sprite")
onready var left_ray = get_node("left_ray")
onready var right_ray = get_node("right_ray")
onready var sound = get_node("sound")

var vel = Vector2()
var acc = Vector2()
var dir = Vector2()

var anim = "idle"

func _ready():
	set_process(true)
	set_fixed_process(true)

func hurt():
	sound.play("pain")

func is_on_floor():
	return left_ray.is_colliding() or right_ray.is_colliding()

func _process(delta):

	if is_on_floor() and vel.y == 0:
		if abs(vel.x) > 0.5:
			anim = "walk"
		else:
			anim = "idle"
	else:
		anim = "jump"

	if anim_sprite.get_animation() != anim:
		anim_sprite.play(anim)

func _fixed_process(delta):
	acc.y = GRAVITY
	acc.x = dir.x * ACCEL

	if acc.x == 0:
		acc.x = vel.x * FRICTION * delta

	vel += acc * delta
	vel.x = clamp(vel.x, -MAX_SPEED, MAX_SPEED)
	var motion = move(vel)
	if is_colliding():
		var n = get_collision_normal()
		motion = n.slide(motion)
		vel = n.slide(vel)
		move(motion)

func _on_controller_left_pressed():
	anim_sprite.set_flip_h(true)
	dir.x = -1

func _on_controller_left_released():
	dir.x = 0

func _on_controller_right_pressed():
	anim_sprite.set_flip_h(false)
	dir.x = 1

func _on_controller_right_released():
	dir.x = 0

func _on_controller_action_1_pressed():
	if is_on_floor():
		sound.play("jump")
		vel.y = MIN_JUMP

func _on_controller_action_2_pressed():
	if is_on_floor():
		sound.play("jump")
		vel.y = MAX_JUMP
