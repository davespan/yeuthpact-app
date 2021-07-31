extends CanvasLayer

signal start_game

func show_message(text):
	$MainContainer/Message.text = text
	$MainContainer/Message.show()
	$MessageTimer.start()
	
func show_highscore(text):
	$MainContainer/Message.text = text
	$MainContainer/Message.show()

func show_quiz_ending():
	show_message("Quiz finished")
	yield($MessageTimer, "timeout")
	$MainContainer/MenuContainer/PlayButton.show()
	$MainContainer/MenuContainer/MenuButton.show()
	show_highscore("Highscore: " + String(data.player.game4.high_score))
	
func update_score(score):
	$ScoreContainer/Score.text = str(score)
	
func _on_MessageTimer_timeout():
	$MainContainer/Message.hide()

func _on_PlayButton_pressed():
	$MainContainer/MenuContainer/PlayButton.hide()
	$MainContainer/MenuContainer/MenuButton.hide()
	emit_signal("start_game")

func _on_MenuButton_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")

func _on_InfoButton_pressed():
	get_tree().paused = true
	$Popup.show()

func _on_BackButton_pressed():
	$Popup.hide()
	get_tree().paused = false

func _on_ExitButton_pressed():
	$Exit.show()

func _on_QuitButton_pressed():
	get_tree().quit()
