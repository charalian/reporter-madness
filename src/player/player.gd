extends Living

# Movement
var walking = false
# Properties
var life = 5
var percentage = 0
var anim_playing = false

func _init():
    speed = 300

func mov_custom():
    walking = false
    
    move.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
    move.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
    
    if move != Vector2(0, 0):
        walking = true

# Ação de reportar com botão pressionado contínuo
    if !walking && Input.is_action_pressed("ui_accept"):
        if !$textureprogress.visible:
            $textureprogress.visible = true
        percentage += 0.01
        $textureprogress.value = percentage
        if $textureprogress.value >= 100: # Quando completar 100, o jogo fechará.
            get_tree().quit()
    else:
        $textureprogress.visible = false
