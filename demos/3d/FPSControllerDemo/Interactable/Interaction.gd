extends RayCast

var current_collider

func _ready():
	set_interaction_text("")

func _process(delta):
	var collider = get_collider()
	if is_colliding() and collider is Interactable:
		if current_collider != collider:
			set_interaction_text(collider.get_interaction_text())
			current_collider = collider
		if Input.is_action_just_pressed("interact"):
			collider.interact()
			set_interaction_text(collider.get_interaction_text())
	elif current_collider:
		current_collider = null
		set_interaction_text("")

func set_interaction_text(text):
	if !text:
		get_tree().call_group("UI", "update_interaction_text", "")
		get_tree().call_group("UI", "hide_interaction_label")
	else:
		var interact_key = OS.get_scancode_string(InputMap.get_action_list("interact")[0].scancode)
		get_tree().call_group("UI", "update_interaction_text", "Press %s to %s" % [interact_key, text])
		get_tree().call_group("UI", "show_interaction_label")
