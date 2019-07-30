extends KinematicBody2D

export var thrust = 10
export var friction = 0.94
export var bullet_speed = 100

onready var Turret = get_node("Turret")

var acc = Vector2()
var vel = Vector2()
var gun_angle = 0

func _ready():
	set_process(true)
	set_fixed_process(true)

func _process(delta):
	Turret.set_global_rot(gun_angle)

func _fixed_process(delta):
	vel += acc
	var motion = move(delta * vel)
	if is_colliding():
		var collider = get_collider()
		body_hit(collider)
		var n = get_collision_normal()
		motion = n.slide(motion)
		vel = n.slide(vel)
		move(motion)
	vel *= friction

func navi_tank(dir):
	set_rot(dir.angle())
	acc = dir * thrust

func stop_tank():
	acc.x = 0
	acc.y = 0

func navi_gun(dir):
	gun_angle = dir.angle()