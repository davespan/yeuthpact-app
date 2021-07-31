extends Area2D

signal shoot

export(PackedScene) var CannonBall

onready var sprite = $Sprite
onready var cannon = $Cannon

enum teams {BLANK, BLACK, RED, GREEN}
var teams_size = teams.size()
var team
var acc = 1

var target = null

func _ready():
	change_team(teams.values()[rand_range(0, teams_size)])
	randomize()

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

func shoot():
	$CannonTimer.start()

func explode():
	$CannonTimer.stop()
	sprite.play("explosion")
	$CollisionShape2D.call_deferred("set_disabled", true)
	$FoV.hide()

func _on_CannonTimer_timeout():
	if not target.is_dead:
		spawn_cannon_ball()
	else:
		$CannonTimer.stop()

func spawn_cannon_ball():
	var dir = target.global_position - global_position
	dir = dir.rotated(rand_range(-0.1, 0.1)).angle()
	emit_signal('shoot', CannonBall, global_position, dir)
	cannon.play()

func _on_Enemy_body_entered(body):
	# Checking for target.position.x > 110 to temporarily solve a bug where the 
	# player explodes on its spawning position
	if body.name == 'Player'and target.position.x > 110:
		body.death()
		explode()

func _on_SearchArea_body_entered(body):
	# Checking for target.position.x > 110 to temporarily solve a bug where the 
	# player is spotted on its spawning position
	if body.name == 'Player' and body.team != self.team and target.position.x > 110:
		shoot()
	else:
		pass

func _on_start_game():
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	$CannonTimer.stop()
