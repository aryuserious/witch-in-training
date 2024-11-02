class_name Ingredient
extends Area2D


enum type { GINGER_ROOT, PEPPERMINT_CANDY, THORNED_ROSE, HONEYCOMB, LEECH, SALT, CAT_WHISKER }
@export var ingredient_type : type
var ingredient_regions : Dictionary = { # the number that is the key matches with the value of each enum element
	0: Rect2(19, 0, 10, 10), # Ginger Root
	1: Rect2(10, 0, 9, 10), # Peppermint Candy
	2: Rect2(29, 0, 10, 10), # Thorned Rose
	3: Rect2(48, 0, 10, 10), # Honeycomb
	4: Rect2(58, 0, 8, 10), # Leech
	5: Rect2(0, 0, 10, 10), # Salt
	6: Rect2(39, 0, 9, 10) # Cat Whisker
}


func _ready():
	# random location
	position = Global.random_spawn()

	# set sprite based off type
	set_sprite_region(ingredient_type)


static func create(ingr_type : type) -> Ingredient:
	var ingredient = Ingredient.new()
	ingredient.ingredient_type = ingr_type
	return ingredient


func set_sprite_region(ingr_type):
	$Sprite.region_rect = ingredient_regions[ingr_type]


static func ingredient_type_as_string(ingr_type : Ingredient.type) -> String:
	if ingr_type or ingr_type == 0:
		match ingr_type:
			Ingredient.type.GINGER_ROOT:
				return "Ginger Root"
			Ingredient.type.PEPPERMINT_CANDY:
				return "Peppermint Candy"
			Ingredient.type.THORNED_ROSE:
				return "Thorned Rose"
			Ingredient.type.HONEYCOMB:
				return "Honeycomb"
			Ingredient.type.LEECH:
				return "Leech"
			Ingredient.type.SALT:
				return "Salt"
			Ingredient.type.CAT_WHISKER:
				return "Cat Whisker"
			_:
				return "???"
	else:
		return "None"
