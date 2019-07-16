extends Spatial

var up

func _ready():
	up = get_global_transform().basis.y
	set_process(true)

func _process(delta):
	var transform = get_global_transform()
	var cam_loc = get_viewport().get_camera().get_global_transform().origin
	var scale = get_scale()
	transform = transform.looking_at(cam_loc, up)
	set_global_transform(transform)
	set_scale(scale)

