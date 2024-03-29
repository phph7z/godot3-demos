extends KinematicBody

var food_types = {}
var can_fire = true

const PROJECTILE_SPEED = 50

func _ready():
	food_types = FileGrabber.get_files("res://Projectiles/FootType/")
	randomize()

func fire():
	if can_fire:
		var random_food = food_types[randi() % food_types.size()]
		var projectile = load(random_food).instance()
		add_child(projectile)
		projectile.set_as_toplevel(true)
		projectile.global_transform = $Forward.global_transform
		var character_forward = global_transform.basis[2].normalized()
		projectile.linear_velocity = character_forward * PROJECTILE_SPEED
		projectile.angular_velocity = Vector3(1,0,0)
		can_fire = false
		$Timer.start()

func _on_Timer_timeout():
	can_fire = true
