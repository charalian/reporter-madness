extends Living

# Onready
onready var player = $"../player"

# Properties
var life = 1

func _init():
    speed = 100

func mov_custom():
    var player_pos = player.position
    var prev_rot = rotation
    look_at(player_pos)
    move = Vector2(speed, 0).rotated(rotation)
    rotation = prev_rot
