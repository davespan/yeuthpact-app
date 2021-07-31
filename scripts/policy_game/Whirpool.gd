extends Area2D

signal contact

func _on_start_game():
	queue_free()

func _on_Whirpool_body_entered(body):
	if body.name == 'Player':
		emit_signal('contact')
	else:
		pass
