extends Node

export (PackedScene) var Enemy
export (PackedScene) var Whirpool

onready var music = $Music
onready var explosion = $ExplosionSound
onready var queen_anim = $Queen/Animation
onready var cheering = $Cheering
onready var spawns = $SpawnPoints/Enemies/SpawnZone.get_child_count()

var enemy_spawn_distance = 650
var whirpool_distance = 600

func _ready():
	data.load_data()
	$Player.connect('dead', self, 'game_over')
	randomize()

func spawn_enemies():
	for i in range (1, 10):
		var enemy = Enemy.instance()
		add_child(enemy)
		var pos_id = int(rand_range(0, spawns))
		var spawn_pos = "Position" + str(pos_id)
		var pos = get_node("SpawnPoints/Enemies/SpawnZone/" + spawn_pos).position
		enemy.position = pos + Vector2(enemy_spawn_distance * i, 0)
		enemy.connect('shoot', self, 'enemy_shooting')
		$HUD.connect("start_game", enemy, "_on_start_game")
		enemy.target = $Player

func spawn_whirpools():
	for i in range (1, 10):
		var whirpool = Whirpool.instance()
		add_child(whirpool)
		var pos_id = int(rand_range(0, spawns))
		var spawn_pos = "Position" + str(pos_id)
		var pos = get_node("SpawnPoints/Whirpools/" + spawn_pos).position
		whirpool.position = pos + Vector2(whirpool_distance * i, 0)
		whirpool.connect('contact', self, 'player_contact')
		$HUD.connect("start_game", whirpool, "_on_start_game")

func player_contact():
	var speed = int(rand_range(0, 2))
	if speed:
		$Player.speed += 60
	else:
		$Player.speed -= 25

func enemy_shooting(CannonBall, pos, dir):
	var cannon_ball = CannonBall.instance()
	add_child(cannon_ball)
	cannon_ball.start(pos, dir)

func game_over():
	$HUD.show_game_over()
	music.stop()
	explosion.play()

func game_won():
	_save_data()
	$HUD.show_game_won()
	music.stop()
	queen_anim.play("Cheer")
	cheering.play()

func new_game():
	queen_anim.stop()
	cheering.stop()
	music.play()
	$HUD.show_message("Get Ready")
	spawn_enemies()
	spawn_whirpools()
	$Player.start($SpawnPoints/Player.position)

func _on_EndZone_body_entered(body):
	game_won()

func _save_data():
	data.player.game1.completed = true
	data.save_data()
