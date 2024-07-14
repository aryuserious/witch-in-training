class_name Cauldron

extends StaticBody2D


var current_ingredients : Array[Ingredient]
var player_in_range : bool = false
var player : Player

var potions = {
    "Healing Potion" : Potion.new( [ Ingredient.new(Ingredient.type.GINGER_ROOT), Ingredient.new(Ingredient.type.PEPPERMINT_CANDY )], "Healing" )
}


func _physics_process(_delta):
    pass


func _on_detection_body_entered(body:Node2D):
    if body is Player:
        player_in_range = true
        player = body


func _on_detection_body_exited(body:Node2D):
    if body is Player:
        player_in_range = false


class Potion:
    enum rarities {
        COMMON = 0,
        UNCOMMON = 1,
        SPECIAL = 2,
        RARE = 3,
        EXTRA_RARE = 4,
        LEGENDARY = 5
    }
    var rarity : rarities
    var ingredients : Array[Ingredient]
    var effect = ""

    func _init(ingrs : Array[Ingredient], effect_param : String, rarity_param = rarities.COMMON):
        ingredients = ingrs
        effect = effect_param
        rarity = rarity_param