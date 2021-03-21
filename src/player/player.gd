extends Living

signal death

onready var enemies = $"../enemy"

var walking_stop = false # Prevents from walking when inside a QTE.
var walking = false
var life = 5
var percentage = 0 
var int_zombies = 0 # Counts how many enemies are touching you. It should be max 2.
var qte_value = 50 # Manages the QTE value.

func _init():
    speed = 300

func _ready():
# warning-ignore:return_value_discarded
    connect("death", enemies, "on_death")

func mov_custom():
    walking = false
    
    if !walking_stop:
        move.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
        move.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
    
        if move != Vector2(0, 0):
            walking = true
    
    move = move * speed

    if walking_stop && int_zombies >= 1:
        qte_value -= 1
        $qte.value = qte_value
        if qte_value < 0:
            get_tree().quit()
    else:
        $col.disabled = false

    if !walking && int_zombies == 0 && Input.is_action_pressed("ui_accept"):
        if !$textureprogress.visible:
            $textureprogress.visible = true
        percentage += 0.1
        $textureprogress.value = percentage
        if $textureprogress.value >= 100:
            get_tree().quit()
    else:
        $textureprogress.visible = false

func _input(event):
    if event.is_action_pressed("ui_accept"):
        if walking_stop:
            qte_value += 20
            if qte_value >= 100:
                qte_success()

func qte_success():
    emit_signal("death")
    qte_value = 50
    walking_stop = false
    int_zombies = 0
    $qte.visible = false
    $col.disabled = false
    life -= 1

# Signals

func _on_area2d_body_entered(body):
    if body.is_in_group("enemies") && !walking_stop:
        int_zombies += 1
        walking_stop = true
        $qte.visible = true
        $col.disabled = true
