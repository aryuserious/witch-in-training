class_name Level

extends Node2D


var ingr_scene = preload("res://scenes/ingredient.tscn")
@onready var cauldron = $Cauldron as Cauldron
@onready var start_timer = $StartTimer as Timer


func _ready():
    cauldron.connect("new_potion", _on_cauldron_new_potion)
    get_tree().paused = true   


func _process(_delta):
    $Stats.player_ingredients_in_range = $Player.ingredients_in_range
    $Stats.player_current_ingredient = $Player.current_ingredient


func _on_cauldron_new_potion(potion : Cauldron.Potion):
    # spawn necessary ingredeinets
    for ingr in potion.ingredients:
        var i = ingr_scene.instantiate()

        if i is Ingredient:
            i = i as Ingredient
            i.ingredient_type = ingr.ingredient_type
            add_child(i)
    
    # spawn extra ingredients
    var num_of_extra_ingrs = randi_range(1, 5)
    for ingr in num_of_extra_ingrs:
        var ei = ingr_scene.instantiate() as Ingredient # ei is extra ingredient
        ei.ingredient_type = randi_range(0, Ingredient.type.size())
        add_child(ei)