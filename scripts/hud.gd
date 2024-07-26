class_name HUD

extends CanvasLayer


var ingredient_types : Array[String]

@export var cauldron : Cauldron


func _ready():
	cauldron.connect("new_potion", _on_cauldron_new_potion)


func _on_cauldron_new_potion(potion : Cauldron.Potion):
	$Panel/VBox/Potion.text = potion.effect + " Potion"

	for ingr in potion.ingredients:
		var t = Ingredient.ingredient_type_as_string(ingr)
		ingredient_types.append(t)
	
	for ingr_type in ingredient_types:
		var label = Label.new()
		label.text = "- " + ingr_type
		$Panel/VBox.add_child(label)
