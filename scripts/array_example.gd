extends StaticBody2D

var a = [3, 4, 8]
var b = a
var c = []

func _ready():
    for item in a:
        c.append(item)

    c.append("HI")
    print(a) # prints [3, 4, 8]

    b.append("GROUND")
    print(a) # prints [3, 4, 8, "GROUND"]

    # Lesson: when setting b to a, if we edit b, we also edit a. when individually adding each element to c,
    # and we edit c, a stays the same, which is what i want in this case.
