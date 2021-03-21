extends Living

onready var player = $"../player"

var life = 1
var int_player = false # When touching player is true/false

func _init():
    speed = 100

func mov_custom():
    if !int_player:
        var player_pos = player.position
        var prev_rot = rotation
        look_at(player_pos)
        move = Vector2(speed, 0).rotated(rotation)
        rotation = prev_rot
    elif int_player:
        move = Vector2.ZERO

func _on_area2d_body_entered(body):
    if body.is_in_group("player") && !int_player:
        int_player = true 

func on_death():
    queue_free()
