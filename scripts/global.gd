extends Node

var difficulty : int = 0
var new_high_score : bool
var high_score : int = 0
var score : int = 0


func _process(_delta):
    if score > high_score:
        high_score = score
    
    match score:
        0:
            difficulty = 0
        5:
            difficulty = 1
        10:
            difficulty =  2
        15:
            difficulty = 3
        20:
            difficulty = 4
        25:
            difficulty = 5
        _:
            difficulty = difficulty