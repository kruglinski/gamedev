extends Node2D

onready var anim_ai = get_node("anim_ai")
onready var anim_timer = get_node("anim_timer")

func _ready():
	randomize()
	anim_timer.set_wait_time(randf()*3)
	anim_timer.start()

func _on_Area2D_body_enter( body ):
	body.enter_spike_man(self, true)

func _on_anim_timer_timeout():
	anim_ai.play("long_walk")
