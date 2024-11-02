class_name PowerUp

extends Area2D


@onready var game_time := get_tree().get_first_node_in_group("game_timer") as Timer


func _ready():
	position = Global.random_spawn()


func activate():
	# start the timer with the time it had left plus the difficulty * 2. They are more useful as time goes on
	game_time.start(ceil(game_time.time_left) + (Global.difficulty * 2))
	queue_free()
