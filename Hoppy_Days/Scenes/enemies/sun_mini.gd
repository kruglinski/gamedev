extends RigidBody2D

func _on_lighting_body_enter( body ):
	body.enter_lighting(self, true)
	queue_free()

func _on_notifier_exit_viewport( viewport ):
	queue_free()
