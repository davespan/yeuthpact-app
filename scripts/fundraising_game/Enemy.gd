extends KinematicBody2D

const GRAVITY = 3000

var speed
var min_speed = 90
var max_speed = 150

var direction
var velocity = Vector2()

func _physics_process(delta):
	velocity.y += GRAVITY * delta
	
	if direction == 1:
		$Animations.flip_h = false
	else:
		$Animations.flip_h = true
		
	velocity.x = speed * direction
	$Animations.play("run")
	
	velocity = move_and_slide(velocity, Vector2.UP)

	for idx in range(get_slide_count()):
		var collision = get_slide_collision(idx)
		if collision.collider.name == 'Player' and not collision.collider.is_dead:
			collision.collider.death()
	
	if is_on_wall():
		direction = direction * -1
		
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_start_game():
	queue_free()
