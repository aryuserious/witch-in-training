extends CanvasLayer


@onready var label = $Label
var player_ingredient_in_range : Ingredient
var player_current_ingredient : Ingredient


func _process(_delta):
    label.text = "Ingredient in Range: " + ingredient_type_as_string(player_ingredient_in_range) + "\nCurrent Ingredient:" + ingredient_type_as_string(player_current_ingredient)
    

func ingredient_type_as_string(ingredient : Ingredient) -> String:
    if ingredient:
        match ingredient.ingredient_type:
            Ingredient.type.GINGER_ROOT:
                return "Ginger Root"
            Ingredient.type.PEPPERMINT_CANDY:
                return "Peppermint Candy"
            Ingredient.type.THORNED_ROSE:
                return "Thorned Rose"
            Ingredient.type.SALT:
                return "Salt"
            _:
                return "???"
    else:
        return "None"