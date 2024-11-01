class_name PowerUp

extends Area2D


@onready var game_time := get_tree().get_first_node_in_group("game_timer") as Timer


func _ready():
	position = Global.random_spawn()


func activate():
	game_time.start(ceil(game_time.time_left) + (Global.difficulty * 2))
	queue_free()
	print(game_time)
