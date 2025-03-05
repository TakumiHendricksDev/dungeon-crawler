extends CharacterBody2D

class_name Character

@export var weapon: Weapon = null
@export var speed: float = 300.0
signal attack_signal(direction: Vector2)

func _ready() -> void:
    link_signals()

func _physics_process(delta: float) -> void:
    handle_character_movement()
    handle_attack_events()

func link_signals():
    if weapon != null:
        attack_signal.connect(weapon.attack)

func handle_attack_events():
    if Input.is_action_pressed("attack_up"):
        attack_signal.emit(Vector2(0, -1))
    if Input.is_action_pressed("attack_down"):
        attack_signal.emit(Vector2(0, 1))
    if Input.is_action_pressed("attack_left"):
        attack_signal.emit(Vector2(-1, 0))
    if Input.is_action_pressed("attack_right"):
        attack_signal.emit(Vector2(1, 0))
    
func handle_character_movement():
    var x_direction: float = handle_horizontal_input()
    var y_direction: float = handle_vertical_input()
    
    move_character(x_direction, y_direction)

func move_character(x_direction, y_direction) -> void:
    var direction = Vector2(x_direction, y_direction)
    if direction.length() > 1:
        direction = direction.normalized()

    velocity = direction * speed

    move_and_slide()

func handle_horizontal_input() -> float:
    var x_direction: float = 0

    if Input.is_action_pressed("move_left"):
        x_direction -= 1
    if Input.is_action_pressed("move_right"):
        x_direction += 1

    return x_direction

func handle_vertical_input() -> float:
    var y_direction: float = 0

    if Input.is_action_pressed("move_up"):
        y_direction -= 1
    if Input.is_action_pressed("move_down"):
        y_direction += 1

    return y_direction
