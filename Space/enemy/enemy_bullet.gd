extends KinematicBody2D

signal score_update(size)

var acc = Vector2(0, 0)
var vel = Vector2(0, 0)
var size = "tiny"

func _ready():
	add_to_group("player_bullets")
	set_fixed_process(true)

func _fixed_process(delta):
	move(vel* delta)
	if is_colliding():
		var collider = get_collider()
		if collider.is_in_group("player"):
			collider.body_hit(self)
		queue_free()

func set_acc(new_acc):
	acc = new_acc
func set_vel(new_vel):
	vel = new_vel

func _on_offscreen_notifier_exit_viewport( viewport ):
	queue_free()

func body_hit(body):
	if body.is_in_group("rocks"):
		body.explode(vel.normalized(), self)