extends KinematicBody

export var mouse_sensitivity = 0.5

onready var camera = $Camera

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	
	var move_direction = Vector3()
	if Input.is_action_pressed("move_forward"):
		move_direction += Vector3.FORWARD
	if Input.is_action_pressed("move_backward"):
		move_direction += Vector3.BACK
	if Input.is_action_pressed("move_left"):
		move_direction += Vector3.LEFT
	if Input.is_action_pressed("move_right"):
		move_direction += Vector3.RIGHT

func _input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y -= mouse_sensitivity * event.relative.x
		camera.rotation_degrees.x -= mouse_sensitivity * event.relative.y
		camera.rotation_degrees.x == clamp(camera.rotation_degrees.x, -90, 90)
