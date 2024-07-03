class_name Ingredient

extends Area2D

enum type { GINGER_ROOT, PEPPERMINT_CANDY, THORNED_ROSE, HONEY, LEECH, SALT, CAT_HAIR }
@export var ingredient_type : type


func _ready():
    # RANDOM LOCATION #
    var x = randi_range(0, 1152)
    var y = randi_range(0, 648)
    position = Vector2(x, y)