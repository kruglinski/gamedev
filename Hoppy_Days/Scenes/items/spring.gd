extends Area2D

func _ready():
	pass

func _on_spring_body_enter( body ):
	body.enter_spring(self)