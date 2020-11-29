extends KinematicBody2D

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO

onready var sprite = $AnimatedSprite
onready var stats = $Stats
onready var playerDetectionZone = $PlayerDetectionZone
onready var hurtbox = $HurtBox
onready var softCollision = $SoftCollision
onready var wanderController = $WanderController
onready var blinkAnimationPlayer = $BlinkAnimationPlayer

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

func _ready():
	state = pick_random_state([IDLE, WANDER])

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, ACCELERATION * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity=velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
			
			if wanderController.get_time_left() == 0:
				state = pick_random_state([IDLE, WANDER])
				wanderController.reset_timer(rand_range(1, 3))

		WANDER:
			seek_player()
			
			if wanderController.get_time_left() == 0:
				state = pick_random_state([IDLE, WANDER])
				wanderController.reset_timer(rand_range(1, 3))
				
			accelerate_towards_point(wanderController.target_position, delta)
			
			if global_position.distance_to(wanderController.target_position) < 5:
				state = pick_random_state([IDLE, WANDER])
				wanderController.reset_timer(rand_range(1,3))
		
		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				accelerate_towards_point(player.global_position, delta)
			else:
				state = IDLE
	
	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta * 400
	velocity = move_and_slide(velocity)


func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()
	

func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	sprite.flip_h = velocity.x < 0


func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE


func _on_HurtBox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * 120
	hurtbox.start_invincibility(0.4)
	hurtbox.show_hit_effect()


func _on_Stats_no_health():
	create_death_effect()
	queue_free()
	

func create_death_effect():
	var deathEffect = DeathEffect.instance()
	get_parent().add_child(deathEffect)
	deathEffect.global_position = $HurtBox/CollisionShape2D.global_position


func _on_HurtBox_invincibility_started():
	blinkAnimationPlayer.play("Start")


func _on_HurtBox_invincibility_ended():
	blinkAnimationPlayer.play("Stop")
