extends KinematicBody2D

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO

onready var stats = $Stats

const DeathEffect = preload("res://EnemyDeathEffect.tscn")

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200

enum {
	IDLE,
	WANDER,
	CHASE
}

var state = CHASE

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, 200 * delta)
		
		WANDER:
			pass
		
		CHASE:
			pass


func _on_HurtBox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * 120


func _on_Stats_no_health():
	create_death_effect()
	queue_free()
	

func create_death_effect():
	var deathEffect = DeathEffect.instance()
	get_parent().add_child(deathEffect)
	deathEffect.global_position = $HurtBox/CollisionShape2D.global_position
