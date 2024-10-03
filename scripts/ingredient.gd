class_name Ingredient

extends Area2D

enum type { GINGER_ROOT, PEPPERMINT_CANDY, THORNED_ROSE, HONEY, LEECH, SALT, CAT_WHISKER }
@export var ingredient_type : type
var ingredient_regions = { # the number that is the key matches with the value of each enum element
	0: Rect2(16, 0, 8, 8), # Ginger Root
	1: Rect2(8, 0, 8, 8), # Peppermint Candy
	2: Rect2(24, 0, 8, 8), # Thorned Rose
	3: Rect2(40, 0, 8, 8), # Honey
	4: Rect2(48, 0, 8, 8), # Leech
	5: Rect2(0, 0, 8, 8), # Salt
	6: Rect2(32, 0, 8, 8) # Cat Whisker
}

var outlined_ingredient_regions = { # the number that is the key matches with the value of each enum element
	0: Rect2(21, 0, 10, 10), # Ginger Root
	1: Rect2(11, 0, 9, 10), # Peppermint Candy
	2: Rect2(31, 0, 10, 10), # Thorned Rose
	3: Rect2(50, 0, 11, 10), # Honey
	4: Rect2(61, 0, 9, 10), # Leech
	5: Rect2(0, 0, 10, 10), # Salt
	6: Rect2(41, 0, 9, 10) # Cat Hair
}

func _ready():
	# random location
	# TODO: make the spawn locations based on difficulty and make it based on distance from player
	var x = randi_range(0, 320)
	var y = randi_range(0, 180)
	global_position = Vector2(x, y)

	# set sprite based off type
	set_sprite_region(ingredient_type)
	#print("ingredient made")


static func create(ingr_type : type) -> Ingredient:
	var ingredient = Ingredient.new()
	ingredient.ingredient_type = ingr_type
	return ingredient


func set_sprite_region(ingr_type):
	$Sprite.region_rect = ingredient_regions[ingr_type]
	#match ingredient_type:
		#type.GINGER_ROOT:
			#if has_node("Sprite"):
				#$Sprite.region_rect = ingredient_regions["ginger root"]
		#type.PEPPERMINT_CANDY:
			#if has_node("Sprite"):
				#$Sprite.region_rect = ingredient_regions["peppermint candy"]
		#type.THORNED_ROSE:
			#if has_node("Sprite"):
				#$Sprite.region_rect = ingredient_regions["thorned rose"]
		#type.SALT:
			#if has_node("Sprite"):
				#$Sprite.region_rect = ingredient_regions["salt"]


static func ingredient_type_as_string(ingr_type : Ingredient.type) -> String:
	if ingr_type or ingr_type == 0:
		match ingr_type:
			Ingredient.type.GINGER_ROOT:
				return "Ginger Root"
			Ingredient.type.PEPPERMINT_CANDY:
				return "Peppermint Candy"
			Ingredient.type.THORNED_ROSE:
				return "Thorned Rose"
			Ingredient.type.HONEY:
				return "Honey"
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
