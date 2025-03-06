extends Node

class_name Weapon

@export var weapon_data: WeaponStats = null

func _ready() -> void:
	if weapon_data != null and weapon_data.sprite_texture != null:
		$Sprite2D.texture = load(weapon_data.sprite_texture)

func attack(direction: Vector2) -> void:
	pass
