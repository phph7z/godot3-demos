extends Spatial

onready var animation_player = $AnimationPlayer
onready var bullet_emitters_base = $BulletEmitters
onready var bullet_emitters = $BulletEmitters.get_children()

export var automatic = false

var fire_point: Spatial
var bodies_to_exclude: Array = []

export var damage = 5
export var ammo = 30

export var attack_rate = 0.2
var attack_timer: Timer
var can_attack = true

signal fired
signal out_of_ammo

func _ready():
	attack_timer = Timer.new()
	attack_timer.wait_time = attack_rate
	attack_timer.connect("timeout", self, "finish_attack")
	attack_timer.one_shot = true
	add_child(attack_timer)


func init(_fire_point: Spatial, _bodies_to_exclude: Array):
	fire_point = _fire_point
	bodies_to_exclude = _bodies_to_exclude
	for bullet_emitter in bullet_emitters:
		bullet_emitter.set_damage(damage)
		bullet_emitter.set_bodies_to_exclude(_bodies_to_exclude)


func rand_scatter_rad(angle: float):
	return rand_range(0, 2 * PI * (angle / 360)) - 2 * PI * (angle / 720)


func attack(attack_input_just_pressed: bool, attack_input_held: bool):
	if !can_attack:
		return
	
	if automatic and !attack_input_held:
		return
	elif !automatic and !attack_input_just_pressed:
		return
	
	if ammo	== 0:
		if attack_input_just_pressed:
			emit_signal("out_of_ammo")
		return
	elif ammo > 0:
		ammo -= 1
	
	var start_transform = bullet_emitters_base.global_transform
	bullet_emitters_base.global_transform = fire_point.global_transform
	for bullet_emitter in bullet_emitters:
		if name == "Shotgun":
			print(rand_scatter_rad(5))
			bullet_emitter.rotation.x = rand_scatter_rad(5)
			bullet_emitter.rotation.y = rand_scatter_rad(5)
		bullet_emitter.fire()
	bullet_emitters_base.global_transform = start_transform
	animation_player.stop()
	animation_player.play("Attack")
	emit_signal("fired")
	can_attack = false
	attack_timer.start()
	
	
func finish_attack():
	can_attack = true
	

func set_active():
	show()


func set_inactive():
	hide()
	
	
	
	
	
	
	
	
