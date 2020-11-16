extends KinematicBody2D

var knockback = Vector2.ZERO

onready var stats = $Stats

const DeathEffect = preload("res://EnemyDeathEffect.tscn")

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)


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
