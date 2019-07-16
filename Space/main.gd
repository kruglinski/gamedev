extends Node2D

var rock_factory = preload("res://rock/rock.tscn")
var ufo_factory = preload("res://enemy/enemy.tscn")

var explosion_factory = preload("res://fx/explosion.tscn")
var player_explosion_factory = preload("res://fx/player_explosion.tscn")

onready var spawn_loc = get_node("spawn_locations")
onready var rock_container = get_node("rock_container")
onready var enemy_container = get_node("enemy_container")
onready var shake_anim = get_node("shake_anim")
onready var HUD = get_node("HUD")
onready var player = get_node("player")

func _ready():
	set_process(true)

func _process(delta):
	if rock_container.get_child_count()==0 and enemy_container.get_child_count() == 0:
		begin_next_level()
		global.level += 1

func begin_next_level():
	HUD.show_message("Wave %d" % global.level)
	for i in range(global.level):
		var loc = spawn_loc.get_child(randi()% spawn_loc.get_child_count())
		spawn_rock("big", loc.get_pos(), Vector2())

	for i in range(global.level):
		var ufo = ufo_factory.instance()
		enemy_container.add_child(ufo)
		ufo.connect("explode", self, "_on_enemy_explode")
		ufo.connect("score_update", HUD, "_on_enemy_score_update")

func spawn_rock(size, pos, vel):
	var rock = rock_factory.instance()
	rock_container.add_child(rock)
	rock.connect("explode", self, "explode_rock")
	rock.connect("score_update", HUD, "_on_rock_score_update")
	rock.init(size, pos, vel)

func explode_rock(size, pos, vel, hit_vel):
	var explosion = explosion_factory.instance()
	add_child(explosion)
	explosion.set_pos(pos)
	shake_anim.play("cam_shake")

	var new_size = global.rock_break_pattern[size]
	if not new_size:
		return
	var new_pos = pos + -hit_vel.tangent().clamped(25)
	var new_vel = vel + -hit_vel.tangent()
	spawn_rock(new_size, new_pos, new_vel)

	new_pos = pos + hit_vel.tangent().clamped(25)
	new_vel = vel + hit_vel.tangent()
	spawn_rock(new_size, new_pos, new_vel)

func _on_player_player_death(pos):
	global.game_over = true
	var explosion = explosion_factory.instance()
	add_child(explosion)
	explosion.set_pos(pos)
	shake_anim.play("cam_shake")
	HUD.show_game_over()

func _on_enemy_explode(pos):
	var explosion = explosion_factory.instance()
	add_child(explosion)
	explosion.set_pos(pos)
	shake_anim.play("cam_shake")

func _on_enemy_ufo_fire( pos ):
	var player_pos = player.get_pos()
	var angle = angle_to_point(player_pos)
