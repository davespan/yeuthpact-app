extends Control

func _on_RichTextLabel_meta_clicked(meta):
	OS.shell_open(meta)

func _on_Button_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")
