extends KinematicBody2D

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO

onready var sprite = $AnimatedSprite
onready var stats = $Stats
onready var playerDetectionZone = $PlayerDetectionZone
onready var hurtbox = $HurtBox
onready var softCollision = $SoftCollision
onready var wanderController = $WanderController

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
	knockback = knockback.move_toward(Vector2.ZERO, ACCELERATION * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, ACCELERATION * delta)
			seek_player()
			
			if wanderController.get_time_left() == 0:
				state = pick_random_state([IDLE, WANDER])
				wanderController.reset_timer(rand_range(1, 3))

		WANDER:
			var direction = global_position.direction_to(wanderController.target_position)
			velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			seek_player()
			
			if wanderController.get_time_left() == 0:
				state = pick_random_state([IDLE, WANDER])
				wanderController.reset_timer(rand_range(1, 3))
			
			if global_position.distance_to(wanderController.target_position) < 5:
				state = pick_random_state([IDLE, WANDER])
				wanderController.reset_timer(rand_range(1,3))
			
			sprite.flip_h = velocity.x < 0
		
		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			else:
				state = IDLE
			sprite.flip_h = velocity.x < 0
	
	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta * 400
	velocity = move_and_slide(velocity)


func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()


func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE


func _on_HurtBox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * 120
	hurtbox.show_hit_effect()


func _on_Stats_no_health():
	create_death_effect()
	queue_free()
	

func create_death_effect():
	var deathEffect = DeathEffect.instance()
	get_parent().add_child(deathEffect)
	deathEffect.global_position = $HurtBox/CollisionShape2D.global_position
