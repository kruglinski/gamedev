extends Area2D

export var child_portal = false

onready var anim = get_node("anim")

var other_portal
var transporting = false

func _ready():

	other_portal = get_node("peer")
	if not other_portal:
		other_portal = get_parent()

	anim.play("portal_blink")

func _on_portal_body_enter( body ):
	if not transporting:
		other_portal.transporting = true
		body.set_pos(other_portal.get_global_pos())
		body.enter_portal(self)

func _on_portal_body_exit( body ):
	transporting = false
