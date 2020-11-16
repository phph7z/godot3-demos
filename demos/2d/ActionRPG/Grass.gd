extends Node2D

const GrassEffect = preload("res://GrassEffect.tscn")

func create_death_effect():
	var grassEffect = GrassEffect.instance()
	get_parent().add_child(grassEffect)
	grassEffect.global_position = global_position


func _on_HurtBox_area_entered(area):
	create_death_effect()
	queue_free()
