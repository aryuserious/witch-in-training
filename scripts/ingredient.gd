class_name Ingredient

extends Area2D


# members


func _ready():
    var x = randi_range(0, 1152)
    var y = randi_range(0, 648)

    position = Vector2(x, y)