class_name Level
extends Node2D


var ingr_scene = preload("res://scenes/ingredient.tscn")
var pu_scene = preload("res://scenes/power_up.tscn")
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
	for ingr_type in potion.ingredient_types:     
		var i = ingr_scene.instantiate()

		if i is Ingredient:
			i = i as Ingredient
			i.ingredient_type = ingr_type
			add_child(i)
	
	# spawn extra ingredients
	var num_of_extra_ingrs = randi_range(1, 5)
	for ingr in num_of_extra_ingrs:
		var ei = ingr_scene.instantiate() as Ingredient # ei is extra ingredient
		ei.ingredient_type = randi_range(0, Ingredient.type.size() - 1) # choose a random ingredient
		add_child(ei)
		
	# possibly spawn powerup if it's not the first round
	if Global.difficulty > 0:
		var num = randf()
		if num < 0.25: # 25% chance
			var pu = pu_scene.instantiate()
			add_child(pu)


func _on_start_timer_timeout():
	$Sounds.game_music.play()


func _on_cauldron_accept_ingredient(_ingr):
	# TODO: make plop volume depend on the ingredient
	$Sounds.potion_plop.play()


func _on_cauldron_reject_ingredient(_ingr):
	# TODO: Play a sound
	pass # Replace with function body.
