extends KinematicBody2D

var move = Vector2()
var life = 3
var walking = false
var percentage = 0

func _process(delta):
    # Isso dói em mim mas é o que tem pra hoje
    var speed = 300 * delta
    if Input.is_action_pressed("ui_up"):
        position.y -= speed
    if Input.is_action_pressed("ui_down"):
        position.y += speed
    if Input.is_action_pressed("ui_left"):
        position.x -= speed
    if Input.is_action_pressed("ui_right"):
        position.x += speed
    move.normalized()
    move_and_slide(move)

func _input(event):
    #Quando apertar E, uma barra circular irá aparecer. Se houver algum movimento, a barra sumirá e parará de acrescentar números.
    if !walking && Input.is_action_pressed("ui_accept"):
        percentage += 0.1
        $textureprogress.value = percentage
        $textureprogress.visible = true
        if $textureprogress.value >= 100: # Quando completar 100, o jogo fechará.
            get_tree().quit()
    else:
        $textureprogress.visible = false
    if !walking && Input.is_action_just_pressed("ui_accept"):
        $anim.play("fade_in")
