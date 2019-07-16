extends AnimatedSprite

onready var sound = get_node("sound")

func _ready():
	self.play("default")
	sound.play("explosion")
	set_process(true)

func _process(delta):
	if not sound.is_active():
		queue_free()
