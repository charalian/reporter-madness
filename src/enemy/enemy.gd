extends Living

# Onready
onready var player = $"../player"

# Properties
var life = 1

func _init():
    speed = -100

func mov_custom():
    var player_pos = player.position
    move = Vector2(speed, 0).direction_to(player_pos)
