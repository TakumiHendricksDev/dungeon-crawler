extends CharacterBody2D

class_name Character

@export var speed: float = 300.0
signal attack_signal(direction: Vector2)

var current_rotation: float = 0

func _ready() -> void:
	# Test code
	var weapon: Weapon = preload("res://Scenes/weapon.tscn").instantiate()
	$AnimatedSprite2D/WeaponSlot.add_child(weapon)
	link_signals(weapon)

func _physics_process(delta: float) -> void:
	handle_character_movement()
	handle_attack_events()

func link_signals(weapon: Weapon):
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
	rotate_character_sprite(x_direction, y_direction)

func rotate_character_sprite(x_direction: float, y_direction: float):
	if x_direction != 0 or y_direction != 0:
		current_rotation = atan2(y_direction, x_direction) + (PI/2)
		$AnimatedSprite2D.rotation = current_rotation

func move_character(x_direction: float, y_direction: float) -> void:
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
