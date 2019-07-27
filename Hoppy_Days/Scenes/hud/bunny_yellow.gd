extends AnimatedSprite

export var walking = false

func _ready():
	if walking:
		play("walk")
	else:
		play("idle")

func _on_Area2D_body_enter( body ):
	body.player_win(self)
