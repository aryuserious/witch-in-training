class_name HUD

extends CanvasLayer


var ingredient_types : Array[String]

@export var cauldron : Cauldron


func _ready():
    cauldron.connect("new_potion", _on_cauldron_new_potion)
    get_parent().get_node("StartTimer").connect("timeout", _on_start_timer_timeout)


func _process(_delta):
    var t = get_parent().get_node("StartTimer") as Timer
    $Start/Countdown.text = str(ceil(t.time_left))


func _on_cauldron_new_potion(potion : Cauldron.Potion):
    $Panel/VBox/Potion.text = potion.effect + " Potion" # it'll end up like: "Healing Potion", "Death Potion", etc.

    for ingr in potion.ingredients: # for every potion ingredient...
        var t = Ingredient.ingredient_type_as_string(ingr) # save the ingredient type to a variable...
        ingredient_types.append(t) # then append that variable to the ingredient types array
    
    for ingr_type in ingredient_types: # for every ingr type in the ingredient types array...
        var label = Label.new() # make a new label...
        label.text = "- " + ingr_type # set the text to the ingredient type... (it'll end up like - Ginger Root, - Throned Rose)
        $Panel/VBox.add_child(label) # add the label to the HUD list


func _on_start_timer_timeout():
    $Start.visible = false
    cauldron.select_potion()
    get_tree().paused = false