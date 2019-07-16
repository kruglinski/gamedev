extends Node2D

var gem_factory = preload("res://gem.tscn")

var gem_container
var hud_score
var hud_game_over
var hud_time_remain
var hud_restart

var timer
var player

var score = 0
var level = 1

func _ready():
	print("window size: ", get_viewport_rect())
	print("safe area: ", OS.get_window_safe_area())
	gem_container = get_node("gem_container")
	timer = get_node("timer")
	player = get_node("player")

	hud_score = get_node("HUD/hud_score")
	hud_game_over = get_node("HUD/hud_game_over")
	hud_time_remain = get_node("HUD/hud_time_remain")
	hud_restart = get_node("HUD/hud_restart")

	hud_score.set_text("SCORE: %-6d" % score)
	hud_time_remain.set_text("TIME: %2d" % timer.get_time_left())

	spawn_gem(level * 10)
	set_process(true)

func _process(delta):
	if gem_container.get_child_count()==0:
		level += 1
		spawn_gem(level * 10)
		timer.stop()
		timer.set_wait_time(timer.get_wait_time()-2)
		timer.start()

	hud_time_remain.set_text("TIME: %2d" % timer.get_time_left())

func spawn_gem(num):
	var screen_size = get_viewport_rect().size
	randomize()
	for _ in range(num):
		var gem = gem_factory.instance()
		gem.connect("gem_grabbed", self, "_on_gem_grabbed")
		gem.set_pos(Vector2(
						rand_range(10, screen_size.width-10),
		 				rand_range(10,screen_size.height-10)
						)
					)
		gem_container.add_child(gem)

func _on_gem_grabbed():
	score += 10
	hud_score.set_text("Score: %-6d" % score)

func game_over():
	player.disable()
	set_process(false)

	hud_game_over.set("visibility/visible", true)
	hud_restart.set("visibility/visible", true)

func _on_Timer_timeout():
	game_over()

func _on_hud_restart_button_up():
	get_tree().reload_current_scene()
