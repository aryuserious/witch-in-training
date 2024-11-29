extends Node

var difficulty : int = 0
var new_high_score : bool
var high_score : int = 0
var score : int = 0
var spawn_area : Rect2 = Rect2(20, 85, 296, 155)


func _process(_delta):
	if score > high_score:
		high_score = score
		new_high_score = true
	else:
		new_high_score = false


func random_spawn() -> Vector2:
	var x = randi_range(spawn_area.position.x, spawn_area.size.x)
	var y = randi_range(spawn_area.position.y, spawn_area.size.y)
	return Vector2(x, y)
