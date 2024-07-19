class_name Cauldron

extends StaticBody2D


signal new_potion(potion : Potion)
var current_potion : Potion
var needed_ingredients : Array[Ingredient]
var current_ingredients : Array[Ingredient]
var player_in_range : bool = false
var player : Player

var potions : Array[Potion] = [
    Potion.new( [ Ingredient.new(Ingredient.type.GINGER_ROOT), Ingredient.new(Ingredient.type.GINGER_ROOT), Ingredient.new(Ingredient.type.PEPPERMINT_CANDY), Ingredient.new(Ingredient.type.THORNED_ROSE) ], "Healing" ),
    Potion.new( [ Ingredient.new(Ingredient.type.THORNED_ROSE), Ingredient.new(Ingredient.type.GINGER_ROOT), Ingredient.new(Ingredient.type.PEPPERMINT_CANDY) ], "Death", 1 )
]


func _ready():
    pass


func _physics_process(_delta):
    if Input.is_action_just_pressed("test"):
        select_potion()


func select_potion():
    var possible_potions : Array[Potion] = [] 

    for potion in potions:
        if Global.difficulty == potion.rarity:
            possible_potions.append(potion)
        else:
            continue
    
    var i = randi_range(0, possible_potions.size() - 1)
    current_potion = possible_potions[i]
    needed_ingredients = current_potion.ingredients
    current_ingredients.clear()
    new_potion.emit(current_potion)
    # for ingr in needed_ingredients:
    #     get_parent().add_child(ingr)


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

    func _init(ingrs : Array[Ingredient], e : String, r = rarities.COMMON):
        ingredients = ingrs
        effect = e
        rarity = r