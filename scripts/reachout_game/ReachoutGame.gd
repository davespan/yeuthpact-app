extends Spatial

export (PackedScene) var Coin

onready var music = $Music
onready var ballon_pop = $BalloonPop
onready var coin_sound = $CoinSound
onready var completed_sound = $GameCompleted
onready var hallway1 = $Hallway1
onready var hallway2 = $Hallway2
onready var coin_holder_size = $Coins.get_child_count()

var coins
var collision_shape = 1

func _ready():
	data.load_data()
	$Player.connect('dead', self, 'game_over')
	hide_hallways()
	randomize()

func new_game():
	hide_hallways()
	coins = 0
	$Player.start($SpawnPosition.transform)
	$HUD.show_message("Get Ready")
	spawn_coins()
	music.play()

func spawn_coins():
	for i in range (0, coin_holder_size):
		var coin = Coin.instance()
		var coin_holder = "Coins/CoinHolder" + str(i)
		get_node(coin_holder).add_child(coin)
		coin.connect('collected', self, '_on_Coin_collected')
		$HUD.connect("start_game", coin, "_on_start_game")

func game_over():
	_save_data()
	ballon_pop.play()
	$HUD.show_game_over()
	music.stop()

func game_won():
	_save_data()
	$Player.set_physics_process(false)
	$Player.linear_velocity = Vector3.ZERO
	$Player.angular_velocity = Vector3.ZERO
	$HUD.show_game_won()
	completed_sound.play()
	music.stop()

func hide_hallways():
	hallway1.hide()
	hallway2.hide()
	hallway1.get_child(collision_shape).disabled = true
	hallway2.get_child(collision_shape).disabled = true

func _save_data():
	if coins >= data.player.game5.high_score:
		data.player.game5.high_score = coins
	if coins >= 8:
		data.player.game5.completed = true
	data.save_data()

func _on_Coin_collected():
	coins += 1
	coin_sound.play()
	
	match coins:
		5:
			hallway1.show()
			hallway1.get_child(collision_shape).disabled = false
		10:
			hallway2.show()
			hallway2.get_child(collision_shape).disabled = false
		15:
			game_won()
