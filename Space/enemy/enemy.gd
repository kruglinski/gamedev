extends KinematicBody2D

var bullet_factory = preload("res://enemy/enemy_bullet.tscn")

signal explode
signal score_update(size)
signal ufo_fire(pos)

export var shield_level = 3
export var bullet_speed = 500

var size = "big"
var speed = 250

var path
var follow
var remote

onready var sound = get_node("sound")
onready var paths = get_node("ufo_paths")
onready var shot_timer = get_node("shot_timer")

func _ready():
	add_to_group("enemy")
	shield_level = max(3, global.level)
	bullet_speed += global.level * 20

	randomize()
	var tex = load(global.enemy_textures[randi() % global.enemy_textures.size()])
	get_node("sprite").set_texture(tex)
	path = paths.get_child(randi() % paths.get_child_count())
	follow = PathFollow2D.new()
	remote = Node2D.new()
	path.add_child(follow)
	follow.add_child(remote)
	follow.set_unit_offset(randf())
	var div = max(1 - global.level / 10, 0.1)
	shot_timer.set_wait_time(3 * div)
	shot_timer.start()
	set_process(true)

func _process(delta):
	follow.set_offset(follow.get_offset() + speed * delta)
	set_pos(remote.get_global_pos())

func explode(hit_vel, body):
	shield_level -= 1
	if shield_level != 0:
		return

	if body.is_in_group("player"):
		emit_signal("score_update", -global.rock_damage[size])
	else:
		emit_signal("score_update", global.rock_points[size])
	emit_signal("explode", get_pos())
	queue_free()

func _on_auto_shot_timeout():
	var pos = get_pos()
	var rot = pos.angle_to_point(global.player_pos)
	var bullet = bullet_factory.instance()
	get_parent().add_child(bullet)
	bullet.set_rot(rot)
	bullet.set_pos(pos)
	bullet.set_vel(Vector2(0, -bullet_speed).rotated(rot))
	sound.play("shot")
