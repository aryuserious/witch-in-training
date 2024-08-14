class_name HUD

extends CanvasLayer


@export var cauldron : Cauldron
@export var game_time : Timer
@export var ingr_list_vbox : VBoxContainer
@export var potion_label : Label


func _ready():
	cauldron.connect("new_potion", _on_cauldron_new_potion)
	get_parent().get_node("StartTimer").connect("timeout", _on_start_timer_timeout)
	$Start.visible = true


func _process(_delta):
	# start timer
	var st = get_parent().get_node("StartTimer") as Timer
	$Start/Countdown.text = str(ceil(st.time_left)) # this is the timer that goes 3 2 1 at the begining

	# game time minutes and seconds
	var s = int(ceil(game_time.time_left)) # if time left is 5.99, s is 6. if time left is 5.08, s is 6. if time left is 4.99, s is 5.
	var m = floor(s/60) # if s/60 is 3.42, m = 3
	s = s % 60 # s is the remainder of s / 60. if s is 90 (1 min and 30 sec), 90 % 60 will be 30. % means remainder of 

	$TimePanel/TimeHBox/Minutes.text = str(m) + ":"
	$TimePanel/TimeHBox/Seconds.text = str(s) if s >= 10 else "0" + str(s) # ternary. var x = (value) if (condition) else (value). this is so that when the number is less than 10 it will say 0:03


func _on_cauldron_new_potion(potion : Cauldron.Potion):
	var ingredient_types : Array[String] = []

	potion_label.text = potion.effect + " Potion" # it'll end up like: "Healing Potion", "Death Potion", etc.

	# delete old ingredients
	for ingr in ingr_list_vbox.get_children():
		ingr.queue_free()

	for ingr in potion.ingredient_types: # for every potion ingredient...
		var t = Ingredient.ingredient_type_as_string(ingr) # save the ingredient type to a variable...
		ingredient_types.append(t) # then append that variable to the ingredient types array
	
	for ingr_type in ingredient_types: # for every ingr type in the ingredient types array...
		var label = Label.new() # make a new label...
		label.text = "- " + ingr_type # set the text to the ingredient type... (it'll end up like - Ginger Root, - Throned Rose)
		ingr_list_vbox.add_child(label) # add the label to the HUD list


func _on_player_game_over():
	get_tree().paused = true
	$GameOverPanel/VBoxContainer/ScoreInfo.text = "You collected " + str(Global.score) + " potions!" + "\nHigh Score: " + str(Global.high_score)

	$GameOverPanel.visible = true


func _on_start_timer_timeout():
	$Start.visible = false
	cauldron.select_potion()
	get_tree().paused = false
	game_time.start()


func _on_retry_button_pressed():
	get_tree().reload_current_scene()