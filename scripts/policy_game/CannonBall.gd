extends Area2D

var speed = 500

var velocity = Vector2()

func start(pos, dir):
	position = pos
	velocity = Vector2(speed, 0).rotated(dir)
	rotation = dir

func _process(delta):
	position += velocity * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_CannonBall_body_entered(body):
	if body.name == 'Player':
		body.death()
	queue_free()
