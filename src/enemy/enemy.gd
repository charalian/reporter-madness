extends Living

onready var player = $"../player"

var life = 1
var int_player = false

func _init():
    speed = 100

func _ready():
    # warning-ignore:return_value_discarded
    player.connect("death", self, "on_death")

func mov_custom():
    var player_pos = player.position
    var prev_rot = rotation
    if !int_player:
        # Will walk towards player
        look_at(player_pos)
        move = Vector2(speed, 0).rotated(rotation)
        rotation = prev_rot
    elif int_player:
        move = Vector2.ZERO
    
    # Will look at player
    if player_pos > position:
        get_node("sprite").set_flip_h(true)
    else:
        get_node("sprite").set_flip_h(false)

func _on_area2d_body_entered(body):
    if body.is_in_group("player") && !int_player:
        int_player = true 

func on_death():
    if int_player == true:
        queue_free()
