extends Spatial


func _on_GoalDetector_body_entered(body, extra_arg_0):
	if body.name == 'Ball':
		if extra_arg_0 == 1:
			print("goal for green")
		elif extra_arg_0 == 2:
			print("goal for blue")
