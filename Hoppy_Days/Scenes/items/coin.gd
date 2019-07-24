extends Area2D

onready var sfx = get_node("sfx")
onready var fx = get_node("fx")
onready var anim_sprite = get_node("anim_sprite")
onready var anim_timer = get_node("anim_timer")

func _ready():
	randomize()
	anim_timer.set_wait_time(randf())
	anim_timer.start()

	fx.interpolate_property(self, "transform/scale",
						Vector2(1,1), Vector2(3, 3), 1,
						Tween.TRANS_QUAD, Tween.EASE_OUT)

	fx.interpolate_property(self, "visibility/opacity",
						1, 0, 1,
						Tween.TRANS_QUAD, Tween.EASE_OUT)

func _on_coin_body_enter( body ):
	clear_shapes()
	body.enter_coin(self)
	sfx.play("coin")
	fx.start()

func _on_fx_tween_complete( object, key ):
	queue_free()

func _on_anim_timer_timeout():
	anim_sprite.play("default")
