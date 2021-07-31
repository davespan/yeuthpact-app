extends RigidBody

signal dead

var is_dead
const speed = 15

func _ready():
	set_physics_process(false)
	hide()

func start(pos):
	is_dead = false
	transform = pos
	show()
	$CollisionShape.disabled = false
	$Timer.start()

func _physics_process(delta):
	var force = Vector3(Input.get_gyroscope().y, Input.get_gyroscope().z, Input.get_gyroscope().x)
	add_central_force(force.normalized() * speed)

func death():
	if not is_dead:
		is_dead = true
		emit_signal("dead")
		$CollisionShape.set_deferred("disabled", true)
		hide()
		linear_velocity = Vector3.ZERO
		angular_velocity = Vector3.ZERO
		set_physics_process(false)

func _on_Enemy_body_entered(body):
	if body.name == "Player":
		death()

func _on_FallDetection_body_entered(body):
	if body.name == "Player":
		death()

func _on_Timer_timeout():
	set_physics_process(true)
