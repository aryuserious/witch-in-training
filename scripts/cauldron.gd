class_name Cauldron
extends StaticBody2D


signal new_potion(potion : Potion) # alerted when a new potion is selected
signal accept_ingredient(ingr : Ingredient) # when the cauldron takes an ingredient from the player
signal reject_ingredient(ingr : Ingredient)
var current_potion : Potion # the potion the player is trying to make
var needed_ingredient_types : Array[Ingredient.type] # the ingrs that are still needed (meaning, once an ingredient gets put into the cauldron that WAS needed, it is no longer needed and gets removed from this array)
var current_ingredients_types : Array[Ingredient.type] # the ingrs that are in the cauldron

var player_in_range : bool = false
@onready var player : Player = get_node("../Player") as Player # . self ./ self ../ parent ../Node sibling

@onready var detection  = get_parent().get_node("CauldronDetection")
@onready var game_time = get_tree().get_first_node_in_group("game_timer") as Timer

var potions : Array[Potion] = [
	Potion.new( [
		Ingredient.type.GINGER_ROOT,
		Ingredient.type.GINGER_ROOT,
		Ingredient.type.PEPPERMINT_CANDY ], "Healing", Color.LIME, 0 ),
	Potion.new( [
		Ingredient.type.THORNED_ROSE,
		Ingredient.type.SALT,
		Ingredient.type.PEPPERMINT_CANDY ], "Love", Color.HOT_PINK, 0 ),
	Potion.new( [
		Ingredient.type.PEPPERMINT_CANDY,
		Ingredient.type.GINGER_ROOT,
		Ingredient.type.SALT ], "Invisibility", Color.PALE_TURQUOISE, 1 ),
	Potion.new( [
		Ingredient.type.THORNED_ROSE,
		Ingredient.type.GINGER_ROOT,
		Ingredient.type.PEPPERMINT_CANDY ], "Death", Color.DARK_SLATE_GRAY, 1 )
]


func _ready():
	player.connect("try_ingredient", _on_player_try_ingredient)
	connect("reject_ingredient", _on_reject_ingredient)
	connect("accept_ingredient", _on_accept_ingredient)


func select_potion():
	# find the possible potions
	var possible_potions : Array[Potion] = [] 

	for potion in potions: # for every potion...
		if Global.difficulty >= potion.rarity: # if the rarity and game difficulty match...
			possible_potions.append(potion) # add it to possible potions
	
	# set new potion
	var i = randi_range(0, possible_potions.size() - 1) # choose a random index
	current_potion = possible_potions[i] # use the random index to choose from the possible potions
	needed_ingredient_types = []
	for ingr_type in current_potion.ingredient_types: # add all the potion's ingredient to the needed_ingredient_type array
		needed_ingredient_types.append(ingr_type)
	current_ingredients_types.clear() # empties the cauldron
	new_potion.emit(current_potion)


func update_needed_ingredient_types(ingr_type : Ingredient.type):
	if ingr_type in needed_ingredient_types: # we no longer need the ingredient type
		needed_ingredient_types.erase(ingr_type) # so remove it


func _on_player_try_ingredient(ingredient : Ingredient, type : Ingredient.type):
	if type in needed_ingredient_types:
		current_ingredients_types.append(type)
		update_needed_ingredient_types(type) # removes the type from the array
		accept_ingredient.emit(ingredient) # let the player know to stop holding the ingredient and remove it from the scene
	else:
		reject_ingredient.emit(ingredient)
	
	# if it is the last ingredient needed in the potion
	if needed_ingredient_types.size() == 0:
		Global.score += 1
		Global.difficulty += 1
		select_potion()
		@warning_ignore("integer_division")
		game_time.start(ceil(game_time.time_left) + 25/Global.difficulty ) # start the game time over, with the wait time being the current time + some time


func _on_accept_ingredient(ingr):
	#$AnimPlayer.play("green")
	$Particles.color = current_potion.color
	$Particles.emitting = true


func _on_reject_ingredient(ingr):
	$AnimPlayer.play("red")


func _on_detection_body_entered(body:Node2D):
	if body is Player:
		player_in_range = true
		
		detection.get_node("Bright").visible = true


func _on_detection_body_exited(body:Node2D):
	if body is Player:
		player_in_range = false

		detection.get_node("Bright").visible = false


class Potion:
	enum rarities {
		COMMON = 0,
		UNCOMMON = 1,
		SPECIAL = 2,
		RARE = 3,
		EXTRA_RARE = 4,
		LEGENDARY = 5
	}
	var rarity : rarities
	var ingredient_types : Array[Ingredient.type]
	var effect = ""
	var color : Color # for the potion splash effect

	func _init(ingr_types : Array[Ingredient.type], e : String, c: Color, r = rarities.COMMON, ):
		ingredient_types = ingr_types
		effect = e
		rarity = r
		color = c
