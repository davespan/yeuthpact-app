extends KinematicBody2D

signal dead

onready var sprite = $Sprite

var speed = 0
var velocity = Vector2()
var is_dead

enum teams {BLANK, BLACK, RED, GREEN}
var teams_size = teams.size()
var team
var acc = 1

func _ready():
	hide()

func start(pos):
	change_team(teams.BLANK)
	is_dead = false
	position = pos
	speed = 250
	show()
	$CollisionShape2D.disabled = false
	
func death():
	if not is_dead:
		is_dead = true
		emit_signal("dead")
		speed = 0
		sprite.play("explosion")
		$CollisionShape2D.set_deferred("disabled", true)

func _physics_process(delta):
	velocity.x = speed
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if Input.is_action_pressed("ui_up"):
		velocity.y = -speed
	elif Input.is_action_pressed("ui_down"):
		velocity.y = speed
	else:
		velocity.y = 0
	
	if Input.is_action_just_pressed("ui_jump"):
		change_team(teams.values()[fmod(acc, teams_size)])
		acc += 1
	
func change_team(new_team):
	team = new_team
	
	match team:
		teams.BLANK:
			sprite.play("blank")
		teams.BLACK:
			sprite.play("black")
		teams.RED:
			sprite.play("red")
		teams.GREEN:
			sprite.play("green")
