extends Living

# Onready
onready var player = $"../player"

# Properties
var life = 1

func _init():
    speed = 100

func mov_custom():
    var player_pos = player.position
    look_at(player_pos)
    move = Vector2(speed, 0)
