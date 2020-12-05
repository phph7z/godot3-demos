extends Node

class_name Interactable

export var interactable_name = "Interactable Object"
export var interaction_text = "Interact"

func get_interaction_text():
	return interaction_text

func interact():
	print("Interacting with %s" % interactable_name)
