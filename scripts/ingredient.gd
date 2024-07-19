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
    var x = randi_range(0, 960)
    var y = randi_range(0, 540)
    global_position = Vector2(x, y)

    # # ADD CHILDREN #
    # var s = Sprite2D.new()
    # s.texture = load("res://assets/ingredients.png")
    # s.scale = Vector2(0.4, 0.4)
    # s.name = "Sprite"
    # s.region_enabled = true
    # add_child(s)
    # set_sprite_region()

    # var collision = CollisionShape2D.new()
    # collision.shape = preload("res://assets/collisionshape.tres")
    # add_child(collision)

    # RANDOM LOCATION #
    print("Ingredient made")
    


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


func _init(ingr_type : type):
    ingredient_type = ingr_type


static func ingredient_type_as_string(ingredient : Ingredient) -> String:
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