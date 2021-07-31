extends Node2D

func _ready():
	data.load_data()
	AudioServer.set_bus_mute(0, data.player.mute)
	$Timer.start()

func _on_Timer_timeout():
	get_tree().change_scene("res://scenes/MainMenu.tscn")
