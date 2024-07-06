class_name Player

extends CharacterBody2D


var speed = 300

var ingredients_in_range : Array[Ingredient] # which ingredient is in range
var current_ingredient : Ingredient # which ingredient is picked up


func _physics_process(_delta):
    move()

    # remember: when using ingredient_in_range or current_ingredient in an if statement
    # it will return false if null, else it will return true
    # if ingredient in range: says true as long as it is not null, but it is NOT a bool, it is
    # an ingredient
    if ingredients_in_range.size() > 0 and not current_ingredient and Input.is_action_just_pressed("pickup"):
        pickup_ingredient()
    else:
        if ingredients_in_range.size() > 0 and current_ingredient and Input.is_action_just_pressed("pickup"):
            drop_ingredient()
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
    current_ingredient = nearest_ingredient()
    # ingredient becomes smaller to look like its being held
    current_ingredient.scale = Vector2(0.75, 0.75)


func drop_ingredient():
    # ingredient looks like its being dropped
    current_ingredient.position.y += 20
    current_ingredient.scale = Vector2(1, 1)
    
    current_ingredient = null


func _on_detection_area_entered(area:Area2D):
    if area is Ingredient:
        ingredients_in_range.append(area) # add the ingredient to the array


func _on_detection_area_exited(area:Area2D):
    if area is Ingredient:
        ingredients_in_range.erase(area) # Array.erase(value) removes the value from the array (takes the ingredient out of the array)


func nearest_ingredient() -> Ingredient:
    # var prev_ingr : Ingredient
    var first_loop = true
    var nearest_ingr

    for ingredient in ingredients_in_range:
        if first_loop:
            first_loop = false
            nearest_ingr = ingredient
        else:
            var nearest_ingr_distance = nearest_ingr.position - position
            var distance = ingredient.position - position

            if nearest_ingr_distance > distance: # current ingr is the new nearest
                nearest_ingr = ingredient
            elif nearest_ingr_distance < distance: # new nearest doesnt change
                pass
    
    return nearest_ingr