class_name Ingredient

extends Area2D

enum type { GINGER_ROOT, PEPPERMINT_CANDY, THORNED_ROSE, HONEY, LEECH, SALT, CAT_HAIR }
@export var ingredient_type : type
var ingredient_regions = { # the number that is the key matches with the value of each enum element
	0: Rect2(16, 0, 8, 8),
	1: Rect2(8, 0, 8, 8),
	2: Rect2(24, 0, 8, 8),
	3: Rect2(40, 0, 8, 8),
	4: Rect2(48, 0, 8, 8),
	5: Rect2(0, 0, 8, 8),
	6: Rect2(32, 0, 8, 8)
}


func _ready():
	# random location
	var x = randi_range(100, 500)
	var y = randi_range(30, 400)
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
			Ingredient.type.CAT_HAIR:
				return "Cat Hair"
			_:
				return "???"
	else:
		return "None"
