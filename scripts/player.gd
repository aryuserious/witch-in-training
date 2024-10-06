class_name Player

extends CharacterBody2D


@export var anim : AnimationPlayer
@export var sprite : Sprite2D

enum {FRONT, BACK, LEFT, RIGHT}
var direction
var normal_vector : Vector2
var speed = 60

var ingredients_in_range : Array[Ingredient] # which ingredient is in range
var current_ingredient : Ingredient # which ingredient is picked up
signal try_ingredient(ingredient : Ingredient, type : Ingredient.type) # when the player tries to put an ingredient into the cauldron
signal game_over()

@onready var cauldron = get_parent().get_node("Cauldron") as Cauldron


func _ready():
	cauldron.connect("accept_ingredient", _on_cauldron_accepted_ingredient)


func _physics_process(_delta):
	move()

	if ingredients_in_range.size() > 0 and not current_ingredient and Input.is_action_just_pressed("pickup"):
		pickup_ingredient()
	
	# drop ingredient but if the player is range of the cauldron, drop it in the caulron
	if current_ingredient and Input.is_action_just_pressed("drop"):
		if cauldron.player_in_range == false:
			drop_ingredient()
		elif cauldron.player_in_range == true:
			try_ingredient.emit(current_ingredient, current_ingredient.ingredient_type)
	
	if current_ingredient:
		# ingredient looks like its being held by the player
		current_ingredient.position = $HandPosition.global_position


func move():
	var input_vector = Input.get_vector("left", "right", "up", "down")
	velocity = input_vector * speed
	move_and_slide()
	
	var is_moving = true
	normal_vector = round(input_vector)
	
	match normal_vector:
		Vector2(0, 1), Vector2(-1, 1), Vector2(1, 1):
			direction = FRONT
		Vector2(0, -1), Vector2(-1, -1), Vector2(1, -1):
			direction = BACK
		Vector2(-1, 0):
			direction = LEFT
		Vector2(1, 0):
			direction = RIGHT
		Vector2(0, 0):
			is_moving = false
		
	animate(direction, is_moving) # if we aren't moving, input_vector will be null


func animate(dir, moving):
	match dir:
		FRONT:
			if moving:
				anim.play("front_walk")
			else:
				anim.play("front_idle")
		BACK:
			if moving:
				anim.play("back_walk")
			else:
				anim.play("back_idle")
		LEFT:
			if moving:
				anim.play("left_idle")
			else:
				anim.play("left_idle")
		RIGHT:
			if moving:
				anim.play("right_idle")
			else:
				anim.play("right_idle")


func pickup_ingredient():
	current_ingredient = nearest_ingredient()
	# ingredient becomes smaller to look like its being held
	current_ingredient.scale = Vector2(0.5, 0.5)


func drop_ingredient():
	# ingredient looks like its being dropped
	current_ingredient.position.y += 10
	current_ingredient.scale = Vector2(1, 1)
	
	current_ingredient = null


func _on_cauldron_accepted_ingredient(ingr : Ingredient):
	ingr.queue_free()
	current_ingredient = null


func _on_detection_area_entered(area:Area2D):
	if area is Ingredient:
		ingredients_in_range.append(area) # add the ingredient to the array


func _on_detection_area_exited(area:Area2D):
	if area is Ingredient:
		ingredients_in_range.erase(area) # Array.erase(value) removes the value from the array (takes the ingredient out of the array)


func nearest_ingredient() -> Ingredient:
	var first_loop = true
	var nearest_ingr

	for ingredient in ingredients_in_range:
		if first_loop:
			first_loop = false
			nearest_ingr = ingredient
		else:
			var nearest_ingr_distance = abs(nearest_ingr.position - position)
			var distance = abs(ingredient.position - position)

			if nearest_ingr_distance > distance: # current ingr is the new nearest
				nearest_ingr = ingredient
			elif nearest_ingr_distance < distance: # new nearest doesnt change
				pass
	
	return nearest_ingr


func _on_game_time_timeout():
	game_over.emit()
