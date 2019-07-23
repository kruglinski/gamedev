extends Control

onready var coin_count = get_node("coin_count")
onready var life_count = get_node("life_count")

func _ready():
	_on_player_update_hud()

func _on_player_update_hud():
	coin_count.set_text("%04d" % global.coin_count)
	life_count.set_text("%04d" % global.life_count)
