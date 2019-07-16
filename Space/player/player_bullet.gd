extends KinematicBody2D

var acc = Vector2(0, 0)
var vel = Vector2(0, 0)

func _ready():
	add_to_group("player_bullets")
	set_fixed_process(true)

func _fixed_process(delta):
	vel += acc
	move(vel* delta)
	if is_colliding():
		var collider = get_collider()
		if collider.is_in_group("rocks") or collider.is_in_group("enemy"):
			body_hit(collider)

func set_acc(new_acc):
	acc = new_acc

func _on_offscreen_notifier_exit_viewport( viewport ):
	queue_free()

func body_hit(body):
	queue_free()
	body.explode(vel.normalized(), self)