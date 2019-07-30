extends Node2D

onready var Controller = get_node("Controller")
onready var Player = get_node("Player")

func _ready():
	Controller.player = Player
