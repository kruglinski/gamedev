extends Area2D

export var effect = 1.3

func _on_spring_body_enter( body ):
	body.enter_spring(self, effect)
