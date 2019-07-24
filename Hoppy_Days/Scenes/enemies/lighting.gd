extends RigidBody2D

onready var sprite = get_node("sprite")

var ice = false

func _ready():
	var tex = load("res://GFX/Particles/lighting_blue.png") if ice else load("res://GFX/Particles/lighting_yellow.png")
	sprite.set_texture(tex)

func _on_lighting_body_enter( body ):
	body.enter_lighting(self, true)
	queue_free()

func _on_notifier_exit_viewport( viewport ):
	queue_free()
