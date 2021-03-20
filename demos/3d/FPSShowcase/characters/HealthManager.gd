extends Spatial

signal dead
signal hurt
signal healed
signal health_changed
signal gibbed

export var max_health = 100
var current_health = max_health

export var gib_at = -10

func _ready():
	init()
	
func init():
	current_health = max_health
	emit_signal("health_changed", current_health)

func hurt(damage: int, direction: Vector3, damage_type="normal"):
	if current_health <= 0:
		return
	current_health -= damage
	if current_health <= gib_at:
		pass #TODO
		emit_signal("gibbed")
		print("gibbed")
	if current_health <= 0:
		emit_signal("dead")
		print("dead")
	else:
		emit_signal("hurt")
	emit_signal("health_changed", current_health)
	print("hurt ", damage, " current health ", current_health)

func heal(amount: int):
	if current_health <= 0:
		return
	current_health += amount
	if current_health > max_health:
		current_health = max_health
	emit_signal("healed")
	emit_signal("health_changed", current_health)
	print("heal ", amount, " current health ", current_health)
