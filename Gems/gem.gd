extends Area2D

onready var tween = get_node("Tween")

signal gem_grabbed

func _ready():
	var sprite = get_node("sprite")
	tween.interpolate_property(sprite, "transform/scale", 
								Vector2(1,1), Vector2(3,3), 0.3, 
								Tween.TRANS_QUAD,Tween.EASE_OUT)
	
	tween.interpolate_property(sprite, "visibility/opacity", 
								1, 0, 0.3, 
								Tween.TRANS_QUAD,Tween.EASE_OUT)

func _on_gem_body_enter( body ):
	if body.get_name()=="player":
		emit_signal("gem_grabbed")
		get_node("sound").play("sound")
		tween.start()

func _on_Tween_tween_complete( object, key ):
	queue_free()
