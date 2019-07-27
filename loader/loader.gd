extends Spatial

func _ready():
	set_process_input(true)

func _input(event):

	if not (event.type == InputEvent.KEY and not event.pressed):
		return

	if Globals.load_resource_pack("res://spotlight.pck"):
		dir_contents("res://")
		# var png = ResourceLoader.load("res://volume_light.png")
		get_tree().change_scene("res://main.tscn")

func dir_contents(path):
    var dir = Directory.new()
    if dir.open(path) == OK:
        dir.list_dir_begin()
        var file_name = dir.get_next()
        while (file_name != ""):
            if dir.current_is_dir():
                print("Found directory: " + file_name)
            else:
                print("Found file: " + file_name)
            file_name = dir.get_next()
    else:
        print("An error occurred when trying to access the path.")