extends KinematicBody2D

var move = Vector2()
var life = 3
var walking = false
var percentage = 0
var speed = 300

func _process(delta):
    move = Vector2(0, 0)
    walking = false
    
    move.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
    move.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
    
    if move != Vector2(0, 0):
        walking = true
    
    move = move * speed
    
    move.normalized()
    move_and_slide(move)
    
    #Quando apertar E, uma barra circular irá aparecer. Se houver algum movimento, a barra sumirá e parará de acrescentar números.
    if !walking && Input.is_action_pressed("ui_accept"):
        if !$textureprogress.visible:
            $anim.stop(true)
            $anim.play("fade_in")
        percentage += 0.1
        $textureprogress.value = percentage
        if $textureprogress.value >= 100: # Quando completar 100, o jogo fechará.
            get_tree().quit()
    else:
        $textureprogress.visible = false
