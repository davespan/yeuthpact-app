extends Area

signal collected

var degrees = 2

func _physics_process(delta):
	rotate_y(deg2rad(degrees))

func _on_Coin_body_entered(body):
	if body.name == "Player":
		emit_signal('collected')
		$AnimationPlayer.play("bounce")
		$Timer.start()

func _on_Timer_timeout():
	queue_free()

func _on_start_game():
	queue_free()
