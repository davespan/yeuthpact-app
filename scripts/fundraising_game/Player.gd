extends KinematicBody2D

signal dead

const GRAVITY = 3000
const SPEED = 250
const JUMP_HEIGHT = 1000

onready var jump_sound = $JumpSound

var is_dead
var velocity = Vector2()

func _ready():
	is_dead = false
	hide()

func _physics_process(delta):
	velocity.y += GRAVITY * delta
	
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		$Animations.flip_h = false
		$Animations.play("run")
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		$Animations.flip_h = true
		$Animations.play("run")
	else:
		velocity.x = 0
		$Animations.play("idle")
		
	if is_on_floor():
		if Input.is_action_pressed("ui_jump"):
			jump_sound.play()
			velocity.y = -JUMP_HEIGHT
	else:
		$Animations.play("jump")
	velocity = move_and_slide(velocity, Vector2.UP)
	
	for idx in range(get_slide_count()):
		var collision = get_slide_collision(idx)
		if collision.collider.is_in_group('enemies') and not is_dead:
			death()

func start(pos):
	is_dead = false
	position = pos
	show()
	$CollisionShape2D.disabled = false

func death():
	if not is_dead:
		is_dead = true
		$CollisionShape2D.disabled = true
		emit_signal("dead")
		hide()

func _on_Boundary_body_entered(_body):
	death()

func _on_Boundary2_body_entered(_body):
	death()
