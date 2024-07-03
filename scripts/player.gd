class_name Player

extends CharacterBody2D


var speed = 300


func _physics_process(_delta):
    move()


func move():
    var dir = Input.get_vector("left", "right", "up", "down")
    velocity = dir * speed
    move_and_slide()