extends KinematicBody2D

signal player_death(pos)
signal shield_level_update(level)
signal score_update(size)

export var thrust = 500
export var friction = 0.94
export var bullet_speed = 100

var view_rect
var view_size
var touch_pos = Vector2(0, 0)
var vel = Vector2(0,0)
var acc = Vector2(0,0)
var shield_level = global.shield_max
var shield_up = true
var shield_level_tex3
var shield_level_tex2
var shield_level_tex1

var bullet_factory = preload("player_bullet.tscn")
onready var sound = get_node("sound")
onready var jet = get_node("jet")
onready var shield = get_node("shield")

func _ready():
	add_to_group("player")
	view_rect = get_viewport_rect()
	view_size = view_rect.size/2
	shield_level_tex3 = load("res://sheets/sheet.shield3.atex")
	shield_level_tex2 = load("res://sheets/sheet.shield2.atex")
	shield_level_tex1 = load("res://sheets/sheet.shield1.atex")

	shield.set_texture(shield_level_tex3)

	set_fixed_process(true)
	set_process(true)

func _process(delta):
	if shield_up and shield_level < global.shield_max:
		shield_level = min(shield_level + global.shield_regen * delta, global.shield_max)
		if shield_level <= 40:
			shield.set_texture(shield_level_tex1)
		elif shield_level <= 70:
			shield.set_texture(shield_level_tex2)
		else:
			shield.set_texture(shield_level_tex3)
		emit_signal("shield_level_update", int(shield_level))

	var pos = get_pos()
	if not view_rect.has_point(pos):
		if pos.x < 0:
			pos.x = view_rect.size.width
		if pos.x > view_rect.size.width:
			pos.x = 0
		if pos.y < 0:
			pos.y = view_rect.size.height;
		if pos.y > view_rect.size.height:
			pos.y = 0
		set_pos(pos)
	global.player_pos = pos

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

func _on_Controller_navi_pressed( dir ):
	acc = dir * 30
	jet.set_hidden(false)

func _on_Controller_navi_released():
	acc = Vector2(0, 0)
	jet.set_hidden(true)

func _on_Controller_action_1_pressed():
	var rot = get_rot()
	var bullet = bullet_factory.instance()
	get_parent().add_child(bullet)
	bullet.set_rot(rot)
	bullet.set_global_pos(get_node("Position2D").get_global_pos())
	bullet.set_acc(Vector2(0, -bullet_speed).rotated(rot))
	sound.play("shot")

func _on_Controller_navi_rotated( angle ):
	set_rot(angle)

func body_hit(body):
	if shield_up:
		if body.is_in_group("rocks") or body.is_in_group("enemy"):
			body.explode(vel.normalized(), self)

		shield_level -= global.rock_damage[body.size]

		if shield_level <= 0:
			shield_up = false
			shield.set_hidden(true)
		elif shield_level <= 40:
			shield.set_texture(shield_level_tex1)
		elif shield_level <= 70:
			shield.set_texture(shield_level_tex2)

		emit_signal("score_update", -global.rock_damage[body.size])
		emit_signal("shield_level_update", int(max(shield_level, 0)))

	if shield_level <= 0:
		emit_signal("player_death", get_pos())
		queue_free()