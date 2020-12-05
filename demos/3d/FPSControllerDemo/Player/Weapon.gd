extends Node

class_name Weapon

export var fire_rate = 0.5
export var clip_size = 5
export var reload_rate = 1

onready var raycast = $"../Head/Camera/RayCast"
var current_ammo = 0
var can_fire = true
var reloading = false

func _ready():
	current_ammo = clip_size	

func _process(delta):
	if reloading:
		update_ui_reloading()
	else:
		update_ui_ammo_count()
	if Input.is_action_just_pressed("primary_fire") and can_fire:
		if current_ammo > 0 and not reloading:
			fire()
		elif not reloading:
			reload()
	
	if Input.is_action_just_pressed("reload") and not reloading:
		reload()
			
func check_collision():
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider.is_in_group("Enemies"):
			collider.queue_free()
			print("kill " + collider.name)

func fire():
	print("fire")
	current_ammo -= 1
	can_fire = false
	check_collision()
	yield(get_tree().create_timer(fire_rate), "timeout")
	can_fire = true

func reload():
	print("reload")
	reloading = true
	yield(get_tree().create_timer(reload_rate), "timeout")
	current_ammo = clip_size
	reloading = false
	print("reload complete")

func update_ui_ammo(text):
	get_tree().call_group("UI", "update_ammo", text)
	
func update_ui_ammo_count():
	update_ui_ammo("%s / %s" % [current_ammo, clip_size])
	
func update_ui_reloading():
	update_ui_ammo("reloading...")
