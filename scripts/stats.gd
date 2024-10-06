extends CanvasLayer


@onready var label = $Label
var player_ingredients_in_range : Array[Ingredient]
var player_current_ingredient : Ingredient


func _process(_delta):
	# shoow and hide stats
	if Input.is_action_just_pressed("show-hide stats"):
		visible = !visible
	
	# get all of the ingredients in range into one string
	var ingrs_in_range_string = ""
	for ingr in player_ingredients_in_range:
		ingrs_in_range_string += Ingredient.ingredient_type_as_string(ingr.ingredient_type) + ", "
	
	var cit = "None" # cit is current ingredient type
	if player_current_ingredient:
		cit = Ingredient.ingredient_type_as_string(player_current_ingredient.ingredient_type)

	label.text = "Ingredient in Range: " + ingrs_in_range_string + "\nCurrent Ingredient:" + cit
