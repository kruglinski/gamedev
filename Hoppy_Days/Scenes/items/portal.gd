extends Area2D

export var child_portal = false

onready var anim = get_node("anim")
onready var sfx = get_node("sfx")

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
		body.enter_portal(self)
		body.set_pos(other_portal.get_global_pos())
		sfx.play("transport")

func _on_portal_body_exit( body ):
	if transporting:
		transporting = false
		body.leave_portal(self)
