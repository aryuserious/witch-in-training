extends Node

var difficulty : int = 0
var new_high_score : bool
var high_score : int = 0
var score : int = 0


func _process(_delta):
    if score > high_score:
        high_score = score