extends KinematicBody2D

signal explode
signal score_update(size)

export var bounce = 100

var vel = Vector2()
var rot = 0
var size = Vector2()
var view_rect = Rect2()
var tex_size = Vector2()
var puff

func init(init_size, init_pos, init_vel):
	randomize()

	size = init_size
	if init_vel.length()>0:
		vel = init_vel
	else:
		vel = Vector2(rand_range(30, 100), 0).rotated(rand_range(0, 2*PI))

	rot = rand_range(-1.5, 1.5)

	var tex = load(global.rock_textures[size][randi() % global.rock_textures[size].size()])
	get_node("sprite").set_texture(tex)
	tex_size = tex.get_size() / 2
	var circle_shape = CircleShape2D.new()
	circle_shape.set_radius(min(tex_size.width, tex_size.height))
	add_shape(circle_shape)
	set_pos(init_pos)

func _ready():
	add_to_group("rocks")
	puff = get_node("puff")
	view_rect = get_viewport_rect()
	set_fixed_process(true)

func show_puff():
	puff.set_global_pos(get_collision_pos())
	puff.set_emitting(true)

func _fixed_process(delta):
	vel = vel.clamped(300)
	set_rot(get_rot() + rot * delta)
	move(vel * delta)
	if is_colliding():
		var collider = get_collider()
		if collider.is_in_group("player") or collider.is_in_group("player_bullets"):
			collider.body_hit(self)
		show_puff()
		vel += get_collision_normal() * bounce
		vel.clamped(300)

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

func explode(hit_vel, body):
	if body.is_in_group("player"):
		emit_signal("score_update", -global.rock_damage[size])
	else:
		emit_signal("score_update", global.rock_points[size])
	emit_signal("explode", size, get_pos(), vel, hit_vel)
	queue_free()