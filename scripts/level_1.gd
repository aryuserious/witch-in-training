extends Node2D


func _process(_delta):
    $Stats.player_ingredients_in_range = $Player.ingredients_in_range
    $Stats.player_current_ingredient = $Player.current_ingredient