class_name Ingredient

extends Area2D

enum type { GINGER_ROOT, PEPPERMINT_CANDY, THORNED_ROSE, HONEY, LEECH, SALT, CAT_HAIR }
@export var ingredient_type : type
var ingredient_regions = {
    "ginger root" : Rect2(123, 15, 55, 57),
    "peppermint candy" : Rect2(4, 16, 63, 59),
}


func _ready():
    set_sprite_texture()
    # RANDOM LOCATION #
    var x = randi_range(0, 960)
    var y = randi_range(0, 540)
    position = Vector2(x, y)


func set_sprite_texture():
    match ingredient_type:
        type.GINGER_ROOT:
            if has_node("Sprite"):
                $Sprite.region_rect = ingredient_regions["ginger root"]
        type.PEPPERMINT_CANDY:
            if has_node("Sprite"):
                $Sprite.region_rect = ingredient_regions["peppermint candy"]