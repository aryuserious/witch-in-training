class_name Cauldron

extends StaticBody2D


var ingredients_needed : Array[Ingredient]
var current_ingredients : Array[Ingredient]
var player_in_range : bool = false
var player : Player


func _physics_process(_delta):
    pass


func _on_detection_body_entered(body:Node2D):
    if body is Player:
        player_in_range = true
        player = body


func _on_detection_body_exited(body:Node2D):
    if body is Player:
        player_in_range = false
