class_name Player

extends CharacterBody2D


var speed = 300

var ingredient_in_range : Ingredient # which ingredient is in range
var current_ingredient : Ingredient # which ingredient is picked up


func _physics_process(_delta):
    move()

    # remember: when using ingredient_in_range or current_ingredient in an if statement
    # it will return false if null, else it will return true
    # if ingredient in range: says true as long as it is not null, but it is NOT a bool, it is
    # an ingredient
    if ingredient_in_range and !current_ingredient and Input.is_action_just_pressed("pickup"):
        pickup_ingredient()
    
    if current_ingredient and Input.is_action_just_pressed("drop"):
        drop_ingredient()
    
    if current_ingredient:
        # ingredient looks like its being held by the player
        current_ingredient.position = $HandPosition.global_position


func move():
    var dir = Input.get_vector("left", "right", "up", "down")
    velocity = dir * speed
    move_and_slide()


func pickup_ingredient():
    current_ingredient = ingredient_in_range
    # ingredient becomes smaller to look like its being held
    current_ingredient.scale = Vector2(0.75, 0.75)


func drop_ingredient():
    # ingredient looks like its being dropped
    current_ingredient.position.y += 20
    current_ingredient.scale = Vector2(1, 1)
    
    current_ingredient = null


func _on_detection_area_entered(area:Area2D):
    if area is Ingredient:
        ingredient_in_range = area # again, this is WHICH ingredient is in range

        print("ingredient detected")


func _on_detection_area_exited(area:Area2D):
    if area is Ingredient:
        ingredient_in_range = null