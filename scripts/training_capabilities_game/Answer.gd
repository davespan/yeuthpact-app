extends KinematicBody2D

signal picked

var speed = 350
var velocity = Vector2()

func init(pos, dir, value):
	$Label.text = value
	position = pos
	rotation = dir
	velocity = Vector2(speed, 0).rotated(rotation)

	
func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.normal)

func _on_Answer_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and not event.pressed:
		emit_signal("picked")
