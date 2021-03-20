extends KinematicBody2D
class_name Living

var speed
var move = Vector2()
var inv = false

func _ready() -> void:
    pass

func _process(delta):
    mov_custom()
    move.normalized()
    move = move_and_slide(move)

# Funcs utilized by other scenes
func mov_custom():
    pass
