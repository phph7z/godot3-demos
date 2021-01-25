extends CanvasLayer

func update_score(player, score):
	var score_label = get_node("Banner/HBoxContainer/Player%sScore" % player)
	score_label.text = str(score)

func _on_Button_pressed():
	get_tree().reload_current_scene()

func game_over(player):
	$Popup/VBoxContainer/Label.text = "Player %s Wins" % player
	$Popup.popup_centered()
