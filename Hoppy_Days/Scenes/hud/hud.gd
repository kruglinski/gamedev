extends Control

onready var coin_count = get_node("coin_count")
onready var life_count = get_node("life_count")
onready var anim_coin = get_node("anim_coin")
onready var anim_life = get_node("anim_life")

var prev_coin
var prev_life

func _ready():
	prev_coin = global.coin_count
	prev_life = global.life_count
	_on_player_update_hud()

func _on_player_update_hud():
	coin_count.set_text("%04d" % global.coin_count)
	life_count.set_text("%04d" % global.life_count)

	if prev_coin != global.coin_count:
		prev_coin = global.coin_count
		anim_coin.play("anim")

	if prev_life != global.life_count:
		prev_life = global.life_count
		anim_life.play("anim")
