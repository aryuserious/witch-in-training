class_name Level

extends Node2D


var ingr_scene = preload("res://scenes/ingredient.tscn")
@onready var cauldron = $Cauldron as Cauldron


func _ready():
    cauldron.connect("new_potion", _on_cauldron_new_potion)


func _process(_delta):
    $Stats.player_ingredients_in_range = $Player.ingredients_in_range
    $Stats.player_current_ingredient = $Player.current_ingredient


func _on_cauldron_new_potion(potion : Cauldron.Potion):
    for ingr in potion.ingredients:
        var i = ingr_scene.instantiate()

        # print("Instantiated node:", i)
        # print("Type of instance:", type_string(typeof(i)))
        # print("Instance script class:", i.get_script())

        if i is Ingredient:
            i = i as Ingredient
            i.ingredient_type = ingr.ingredient_type
            add_child(i)
            

            # print("instance is of type ingredient")
        else:
            pass
            # print("instance is not of type ingredient, instead it is: ", type_string(typeof(i)))


