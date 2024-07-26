class_name Cauldron

extends StaticBody2D


signal new_potion(potion : Potion) # alerted when a new potion is selected
var current_potion : Potion # the potion the player is trying to make
var needed_ingredients : Array[Ingredient] # the ingrs that are still needed (meaning, once an ingredient gets put into the cauldron that WAS needed, it is no longer needed and gets removed from this array)
var current_ingredients : Array[Ingredient] # the ingrs that are in the cauldron

var player_in_range : bool = false
var player : Player

@onready var detection = get_parent().get_node("CauldronDetection")

var potions : Array[Potion] = [
    Potion.new( [ Ingredient.create(Ingredient.type.GINGER_ROOT), Ingredient.create(Ingredient.type.GINGER_ROOT), Ingredient.create(Ingredient.type.PEPPERMINT_CANDY) ], "Healing" ),
    Potion.new( [ Ingredient.create(Ingredient.type.THORNED_ROSE), Ingredient.create(Ingredient.type.GINGER_ROOT), Ingredient.create(Ingredient.type.PEPPERMINT_CANDY) ], "Death", 1 )
]


func _ready():
    pass


func _physics_process(_delta):
    update_needed_ingredients()


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


func update_needed_ingredients():
    if current_ingredients:
        for ci in current_ingredients: # for every ingredient that is in the cauldron...
            for ni in needed_ingredients: # go through every needed ingredient...
                if ci.ingredient_type == ni.ingredient_type: # and if they have the same type...
                    needed_ingredients.erase(ni) # take the needed ingredient out of the needed ingredients array


# func all_ingrs_are_required() -> bool:
#     var ingrs_req_status : Array[bool] # if first ingr is required and the last 2 are not, array is [true, false, false]
#     # (describe here)
#     for ingr in current_ingredients:
#         var ingr_type := ingr.ingredient_type as Ingredient.type # c
#         var ingr_is_req : bool

#         # get needed ingredient types into an array
#         var req_ingr_types : Array[Ingredient.type]
#         for ni in current_potion.ingredients:
#             req_ingr_types.append(ni.ingredient_type)
        
#         if ingr_type in req_ingr_types:
#             ingr_is_req



func _on_detection_body_entered(body:Node2D):
    if body is Player:
        player_in_range = true
        player = body as Player
        
        detection.get_node("Bright").visible = true


func _on_detection_body_exited(body:Node2D):
    if body is Player:
        player_in_range = false

        detection.get_node("Bright").visible = false


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