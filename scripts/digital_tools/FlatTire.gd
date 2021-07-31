extends TextureRect

signal dead
signal correct

var value = 4

func _ready():
	$BlowoutSound.play()
	$Sprite.visible = true

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
