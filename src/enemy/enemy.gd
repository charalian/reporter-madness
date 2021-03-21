extends Living

onready var player = $"../player"
var life = 1
var int_player = false # Um sim/não de estiver tocando no player

func _init():
    speed = 100

func mov_custom():
    if !int_player: # Se int_player for falso, mova-se típicamente.
        var player_pos = player.position
        var prev_rot = rotation
        look_at(player_pos)
        move = Vector2(speed, 0).rotated(rotation)
        rotation = prev_rot
    elif int_player: # Se int_player for verdadeiro, deixe inanimado.
        move = Vector2.ZERO

func _on_area2d_body_entered(body):
    if body.is_in_group("player") && !int_player: # Quando colidir com player
        int_player = true # Mude int_player para verdadeiro

func on_death(): # Quando morrer, queue_free().
    queue_free()
