class_name Thing
extends Node

func _process(delta):
	if Input.is_action_pressed("click"):
		var s = Sprite2D.new()
		s.texture = preload("res://assets/art/circle0.png")
		s.scale = Vector2(0.25, 0.25)
		
		var x = randi_range(Global.spawn_area.position.x, Global.spawn_area.size.x)
		var y = randi_range(Global.spawn_area.position.y, Global.spawn_area.size.y)
		s.global_position = Vector2(x, y)
		add_child(s)
