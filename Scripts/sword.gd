extends Weapon

class_name Sword

func attack(direction: Vector2) -> void:
	# Trigger visual and/or animation
	print("Damage: %s" % [str(weapon_data.damage)])
