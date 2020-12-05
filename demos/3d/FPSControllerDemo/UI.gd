extends Control

onready var ammo_label = $Label
onready var interaction_label = $InteractionLabel

func _ready():
	interaction_label.set_visible(false)

func update_ammo(text):
	ammo_label.set_text(text)

func show_interaction_label():
	interaction_label.set_visible(true)
	
func hide_interaction_label():
	interaction_label.set_visible(false)

func update_interaction_text(text):
	interaction_label.set_text(text)
