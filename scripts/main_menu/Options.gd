extends Control

var yes = "Yes"
var no = "No"

func _ready():
	data.load_data()
	set_data()
	$CheckButton.pressed = not data.player.mute

func _on_Back_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")

func set_data():
	$VBoxContainer3/DTHS.text = str(data.player.game2.high_score)
	$VBoxContainer3/FHS.text = str(data.player.game3.high_score)
	$VBoxContainer3/TCHS.text = str(data.player.game4.high_score)
	$VBoxContainer3/RHS.text = str(data.player.game5.high_score)
	
	if data.player.game1.completed:
		$VBoxContainer2/Completed1.text = yes
	else:
		$VBoxContainer2/Completed1.text = no
	if data.player.game2.completed:
		$VBoxContainer2/Completed2.text = yes
	else:
		$VBoxContainer2/Completed2.text = no
	if data.player.game3.completed:
		$VBoxContainer2/Completed3.text = yes
	else:
		$VBoxContainer2/Completed3.text = no
	if data.player.game4.completed:
		$VBoxContainer2/Completed4.text = yes
	else:
		$VBoxContainer2/Completed4.text = no
	if data.player.game5.completed:
		$VBoxContainer2/Completed5.text = yes
	else:
		$VBoxContainer2/Completed5.text = no


func _on_Reset_pressed():
	data.player.game1.completed = false
	data.player.game2.high_score = 0
	data.player.game2.completed = false
	data.player.game3.high_score = 0
	data.player.game3.completed = false
	data.player.game4.high_score = 0
	data.player.game4.completed = false
	data.player.game5.completed = false
	data.player.game5.high_score = 0
	data.save_data()
	set_data()

func _on_CheckButton_pressed():
	data.player.mute = not data.player.mute
	AudioServer.set_bus_mute(0, data.player.mute)
	data.save_data()
