extends CanvasLayer

signal start_game

func _ready():
	$MobileControls.hide()

func show_message(text):
	$MainContainer/Message.text = text
	$MainContainer/Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	yield($MessageTimer, "timeout")
	$MainContainer/MenuContainer/PlayButton.show()
	$MainContainer/MenuContainer/MenuButton.show()
	$MobileControls.hide()
	
func show_game_won():
	show_message("You delivered the Message!")
	yield($MessageTimer, "timeout")
	$MainContainer/MenuContainer/PlayButton.show()
	$MainContainer/MenuContainer/MenuButton.show()
	show_victory("Mission accomplished!")
	$MobileControls.hide()
	
func show_victory(text):
	$MainContainer/Message.text = text
	$MainContainer/Message.show()

func _on_MessageTimer_timeout():
	$MainContainer/Message.hide()

func _on_PlayButton_pressed():
	$MainContainer/MenuContainer/PlayButton.hide()
	$MainContainer/MenuContainer/MenuButton.hide()
	$MobileControls.show()
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
