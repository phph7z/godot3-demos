extends "res://Scenes/Characters/Character.gd"

func _physics_process(delta):
	if $RayCast.is_colliding() and $RayCast.get_collision_mask_bit(1):
		fire()
