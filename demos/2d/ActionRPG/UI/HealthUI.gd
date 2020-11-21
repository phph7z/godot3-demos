extends Control

onready var healthFull = $HealthFull
onready var healthEmpty = $HealthEmpty
onready var stats = PlayerStats


func _ready():
	stats.connect("max_health_changed", self, "update_max_hearts")
	stats.connect("health_changed", self, "update_hearts")
	update_max_hearts(stats.max_health)
	update_hearts(stats.health)


func update_max_hearts(value):
	healthEmpty.rect_size.x = value * 15


func update_hearts(value):
	healthFull.rect_size.x = value * 15
