extends TextureRect

signal dead
signal correct

var value = 3

func _ready():
	$BrokenLight.play()

func can_drop_data(position, data):
	return data

func drop_data(position, data):
	if data == value:
		emit_signal("correct")
	else:
		emit_signal("dead")
	queue_free()

func _on_Timer_timeout():
	emit_signal("dead")
	queue_free()
