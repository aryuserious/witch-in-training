class_name Cauldron

extends StaticBody2D


signal new_potion(potion : Potion) # alerted when a new potion is selected
signal accept_ingredient(ingr : Ingredient) # when the cauldron takes an ingredient from the player
var current_potion : Potion # the potion the player is trying to make
var needed_ingredient_types : Array[Ingredient.type] # the ingrs that are still needed (meaning, once an ingredient gets put into the cauldron that WAS needed, it is no longer needed and gets removed from this array)
var current_ingredients_types : Array[Ingredient.type] # the ingrs that are in the cauldron

var player_in_range : bool = false
@onready var player : Player = get_node("../Player") as Player # . self ./ self ../ parent ../Node sibling

@onready var detection = get_parent().get_node("CauldronDetection")
@onready var game_time = get_node("../GameTime") as Timer

var potions : Array[Potion] = [
    Potion.new( [
        Ingredient.type.GINGER_ROOT,
        Ingredient.type.GINGER_ROOT,
        Ingredient.type.PEPPERMINT_CANDY ], "Healing", 0 ),
    Potion.new( [
        Ingredient.type.THORNED_ROSE,
        Ingredient.type.SALT,
        Ingredient.type.PEPPERMINT_CANDY ], "Love", 0 ),
    Potion.new( [
        Ingredient.type.PEPPERMINT_CANDY,
        Ingredient.type.GINGER_ROOT,
        Ingredient.type.SALT ], "Invisibility", 0 ),
    Potion.new( [
        Ingredient.type.THORNED_ROSE,
        Ingredient.type.GINGER_ROOT,
        Ingredient.type.PEPPERMINT_CANDY ], "Death", 1 )
]


func _ready():
    player.connect("try_ingredient", _on_player_try_ingredient)


func _physics_process(_delta):
    pass

    # if needed_ingredients.size() == 0:
    #     select_potion()


func select_potion():
    # find the possible potions
    var possible_potions : Array[Potion] = [] 

    for potion in potions: # for every potion...
        if Global.difficulty >= potion.rarity: # if the rarity and game difficulty match...
            possible_potions.append(potion) # add it to possible potions
    
    # set new potion
    var i = randi_range(0, possible_potions.size() - 1) # choose a random index
    current_potion = possible_potions[i] # use the random index to choose from the possible potions
    needed_ingredient_types = []
    for ingr_type in current_potion.ingredient_types: # add all the potion's ingredient to the needed_ingredient_type array
        needed_ingredient_types.append(ingr_type)
    current_ingredients_types.clear() # empties the cauldron
    new_potion.emit(current_potion)


func update_needed_ingredients(ingr_type : Ingredient.type):
    if ingr_type in needed_ingredient_types:
        needed_ingredient_types.erase(ingr_type)


func all_ingrs_are_required() -> bool: # does nothing rn
    return true
    # var ingrs_req_status : Array[bool] = [] # if first ingr is required and the last 2 are not, array is [true, false, false]
    # # (describe here)
    # for ingr in current_ingredients:
    #     var ingr_type := ingr.ingredient_type as Ingredient.type
    #     var ingr_is_req : bool

    #     # get needed ingredient types into an array
    #     var req_ingr_types : Array[Ingredient.type] = []
    #     for ni in current_potion.ingredients:
    #         req_ingr_types.append(ni.ingredient_type)
        
    #     if ingr_type in req_ingr_types:
    #         ingr_is_req = true
    #     else:
    #         ingr_is_req = false
        
    #     ingrs_req_status.append(ingr_is_req)
    
    # if false in ingrs_req_status:
    #     return false
    # else:
    #     return true


func _on_player_try_ingredient(ingredient : Ingredient, type : Ingredient.type):
    if type in needed_ingredient_types:
        current_ingredients_types.append(type)
        update_needed_ingredients(type)
        accept_ingredient.emit(ingredient)
    else:
        print("You don't need that ingredient")
        for nit in needed_ingredient_types:
            print("You need ", Ingredient.ingredient_type_as_string(nit))
        print("But you tried to put a(n)", Ingredient.ingredient_type_as_string(type))
    
    # if it is the last ingredient needed in the potion
    if needed_ingredient_types.size() == 0:
        print("You completed a potion")
        Global.score += 1
        select_potion()
        game_time.start(ceil(game_time.time_left) + Global.difficulty ) # start the game time over, with the wait time being the current time + 10 secs


func _on_detection_body_entered(body:Node2D):
    if body is Player:
        player_in_range = true
        
        detection.get_node("Bright").visible = true


func _on_detection_body_exited(body:Node2D):
    if body is Player:
        player_in_range = false

        detection.get_node("Bright").visible = false


class Potion:
    enum rarities {
        COMMON = 5,
        UNCOMMON = 4,
        SPECIAL = 3,
        RARE = 2,
        EXTRA_RARE = 1,
        LEGENDARY = 0
    }
    var rarity : rarities
    var ingredient_types : Array[Ingredient.type]
    var effect = ""

    func _init(ingr_types : Array[Ingredient.type], e : String, r = rarities.COMMON):
        ingredient_types = ingr_types
        effect = e
        rarity = r