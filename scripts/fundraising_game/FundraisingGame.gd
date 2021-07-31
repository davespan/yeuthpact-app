extends Node

export (PackedScene) var Enemy
export (PackedScene) var Pickup

onready var music = $Music
onready var coin_sound = $CoinSound
onready var item_sound = $ItemSound
onready var death_sound = $DeathSound

var score

func _ready():
	data.load_data()
	$Player.connect('dead', self, 'game_over')
	randomize()

func game_over():
	_save_data()
	$EnemySpawnTimer.stop()
	$PickupSpawnTimer.stop()
	$HUD.show_game_over()
	music.stop()
	death_sound.play()

func new_game():
	score = 0
	$Player.start($SpawnPoints/Player.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	music.play()

func _on_EnemySpawnTimer_timeout():
	spawn_enemy()
	
func _on_PickupSpawnTimer_timeout():
	spawn_pickup()
	
func _on_StartTimer_timeout():
	$EnemySpawnTimer.start()
	$PickupSpawnTimer.start()
	
func spawn_enemy():
	var enemy = Enemy.instance()
	add_child(enemy)
	enemy.speed = int(rand_range(enemy.min_speed, enemy.max_speed))
	var is_left = int(rand_range(0, 2))
	if is_left:
		enemy.direction = 1
		enemy.position = $SpawnPoints/Left.position
	else:
		enemy.direction = -1
		enemy.position = $SpawnPoints/Right.position
		
	$HUD.connect("start_game", enemy, "_on_start_game")
	
func spawn_pickup():
	var pickup = Pickup.instance()
	add_child(pickup)
	var pos_id = int(rand_range(0, $SpawnPoints/PickupsSpawnPoints.get_child_count()))
	var spawn_pos = "Position" + str(pos_id)
	var type = int(rand_range(0, pickup.textures.size()))
	pickup.init(type, get_node("SpawnPoints/PickupsSpawnPoints/" + spawn_pos).position)
	
	pickup.connect('pickup', self, '_on_Pickup', [type])
	
	$HUD.connect("start_game", pickup, "_on_start_game")

func _on_Pickup(type):
	
	if type in range(0, 5):
		coin_sound.play()
		score += 1
	elif type in range(5, 7):
		item_sound.play()
		score += 8
	elif type in range(7, 10):
		item_sound.play()
		score += 6
	elif type == 10:
		item_sound.play()
		score += 10
	$HUD.update_score(score)

func _save_data():
	if score >= data.player.game3.high_score:
		data.player.game3.high_score = score
	if score >= 20:
		data.player.game3.completed = true
	data.save_data()
