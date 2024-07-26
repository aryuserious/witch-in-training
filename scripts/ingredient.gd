class_name Ingredient

extends Area2D

enum type { GINGER_ROOT, PEPPERMINT_CANDY, THORNED_ROSE, HONEY, LEECH, SALT, CAT_HAIR }
@export var ingredient_type : type
var ingredient_regions = {
    "ginger root" : Rect2(123, 15, 55, 57),
    "peppermint candy" : Rect2(4, 16, 63, 59),
    "thorned rose" : Rect2(224, 21, 51, 49),
    "salt" : Rect2(308, 21, 67, 55)
}


func _ready():
    # random location
    var x = randi_range(0, 960)
    var y = randi_range(0, 540)
    global_position = Vector2(x, y)

    # set sprite based off type
    set_sprite_region()
    print("ingredient made")


static func create(ingr_type : type) -> Ingredient:
    var ingredient = Ingredient.new()
    ingredient.ingredient_type = ingr_type
    return ingredient


func set_sprite_region():
    match ingredient_type:
        type.GINGER_ROOT:
            if has_node("Sprite"):
                $Sprite.region_rect = ingredient_regions["ginger root"]
        type.PEPPERMINT_CANDY:
            if has_node("Sprite"):
                $Sprite.region_rect = ingredient_regions["peppermint candy"]
        type.THORNED_ROSE:
            if has_node("Sprite"):
                $Sprite.region_rect = ingredient_regions["thorned rose"]
        type.SALT:
            if has_node("Sprite"):
                $Sprite.region_rect = ingredient_regions["salt"]


static func ingredient_type_as_string(ingr_type : Ingredient.type) -> String:
    if ingr_type or ingr_type == 0:
        match ingr_type:
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