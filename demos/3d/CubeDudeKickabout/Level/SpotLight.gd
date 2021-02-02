extends SpotLight

func _ready():
	hide()

func freeze(player_id):
	var Player1 = get_tree().get_root().find_node("PlayerBlue", true, false)
	var Player2 = get_tree().get_root().find_node("PlayerGreen", true, false)
	
	var target
	if player_id == 1:
		target = Player1.translation
	else:
		target = Player2.translation
	
	look_at(target, Vector3(0,1,0))
	show()


func reset():
	hide()
