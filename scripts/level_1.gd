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
        var i = Ingredient.new(ingr.ingredient_type)
        add_child(i)
