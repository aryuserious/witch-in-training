extends CanvasLayer


@onready var label = $Label
var player_ingredients_in_range : Array[Ingredient]
var player_current_ingredient : Ingredient


func _process(_delta):
    var ingrs_in_range_string = ""
    for ingr in player_ingredients_in_range:
        ingrs_in_range_string += Ingredient.ingredient_type_as_string(ingr) + ", "
    
    label.text = "Ingredient in Range: " + ingrs_in_range_string + "\nCurrent Ingredient:" + Ingredient.ingredient_type_as_string(player_current_ingredient)