extends DirectionalLight

func _ready():
	reset()
	
	
func freeze(player_id):
	$AnimationPlayer.play("Fade")
	

func reset():
	light_energy = 1.5
