extends Weapon

export var fire_range = 2

func _ready():
	raycast.cast_to = Vector3(0, 0, -fire_range)
