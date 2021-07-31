extends Node

export (PackedScene) var Tool
export (Array, PackedScene) var Damages

onready var music = $Music
onready var correct_tool_sound = $CorrectToolSound
onready var lost_sound = $LostSound
onready var headlight = $HeadLight

var wrench = preload("res://assets/sprites/digital_tools_game/wrench.png")
var paint_bucket = preload("res://assets/sprites/digital_tools_game/paint_bucket.png")
var light_bulb = preload("res://assets/sprites/digital_tools_game/light_bulb.png")
var air_compressor = preload("res://assets/sprites/digital_tools_game/air_compressor.png")

var tool_sprites = [wrench, paint_bucket, light_bulb, air_compressor]

var light = true

var score

func _ready():
	data.load_data()
	randomize()

func game_over():
	_save_data()
	get_tree().call_group("damage", "queue_free")
	$SpawnDmgTimer.stop()
	$HUD.show_game_over()
	music.stop()
	lost_sound.play()

func new_game():
	score = 0
	$SpawnDmgTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	instantiate_tools()
	music.play()

func instantiate_tools():
	for i in range (1, (tool_sprites.size() + 1)):
		var tool_tr = Tool.instance()
		add_child(tool_tr)
		var spawn_pos = "Position" + str(i)
		var pos = get_node("ToolsPositions/" + spawn_pos).position
		tool_tr.set_position(pos)
		tool_tr.init(i, tool_sprites[i - 1])

func _on_SpawnDmgTimer_timeout():
	spawn_damage()
	$SpawnDmgTimer.wait_time = int(rand_range(2, 5))

func spawn_damage():
	var pick = int(rand_range(0, $DmgPositions.get_child_count()))
	var damage = Damages[pick].instance()
	add_child(damage)
	var spawn_pos = "Position" + str(pick)
	var pos = get_node("DmgPositions/" + spawn_pos).position
	damage.set_position(pos)
	damage.connect('correct', self, '_on_right_tool')
	damage.connect('dead', self, 'game_over')

func _on_right_tool():
	score += 1
	correct_tool_sound.play()
	$HUD.update_score(score)
	
func _save_data():
	if score >= data.player.game2.high_score:
		data.player.game2.high_score = score
	if score >= 15:
		data.player.game2.completed = true
	data.save_data()

