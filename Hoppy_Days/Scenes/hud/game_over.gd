extends CanvasLayer

func _ready():
	get_node("StreamPlayer").play()

func _on_Button_button_up():
	get_tree().change_scene("res://main.tscn")