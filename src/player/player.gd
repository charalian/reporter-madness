extends Living

signal death
onready var enemies = $"../enemy"
var walking_stop = false
var walking = false
var life = 5
var percentage = 0
var int_zombies = 0
var qte_value = 50

func _init():
    speed = 300

func _ready():
    connect("death", enemies, "on_death")

func mov_custom():
    walking = false
    # Há ifs de walking_stop para quando estiver ativado, o player não poder se mover
    if !walking_stop:
        move.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
        move.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
    
        if move != Vector2(0, 0):
            walking = true
    
    move = move * speed

    if walking_stop && int_zombies >= 1: # Faz o nó QTE tirar menos 1 constantemente e associa a variável qte_value ao valor do nó.
        qte_value -= 1
        $qte.value = qte_value
        if qte_value < 0:
            get_tree().quit() # Se fracassar no QTE, o jogo fecha.
    else:
        $col.disabled = false # Quando sair do QTE, colisão reativará. Tem como fazer algo tipo process numa func separada?

    if !walking && int_zombies == 0 && Input.is_action_pressed("ui_accept"):
        if !$textureprogress.visible:
            $textureprogress.visible = true
        percentage += 0.1
        $textureprogress.value = percentage
        if $textureprogress.value >= 100: # Quando completar 100, o jogo fechará.
            get_tree().quit()
    else:
        $textureprogress.visible = false

func _input(event):
    if Input.is_action_pressed("ui_accept"):
            if walking_stop: # Isso adicionará mais 20 ao valor do nó QTE
                qte_value += 20
                if qte_value >= 100: # Se você pressionar até o 100, QTE encerrará.
                    emit_signal("death")
                    qte_value = 50
                    walking_stop = false
                    int_zombies = 0
                    $qte.visible = false
                    $col.disabled = false
                    life -= 1

func _on_area2d_body_entered(body):
    if body.is_in_group("enemies") && !walking_stop: # Detecta se o inimigo te tocou
        int_zombies += 1
        walking_stop = true
        $qte.visible = true
        $col.disabled = true
