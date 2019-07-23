extends Area2D

onready var anim = get_node("anim")

func _ready():
	anim.play("portal_blink")

func _on_portal_body_enter( body ):
	body.enter_portal(self)
