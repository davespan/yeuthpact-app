extends MarginContainer

onready var rocket_animation = $HBoxContainer/VBoxContainerR/CenterContainer/SpaceRocket/LaunchAnimation
onready var rocket_sound = $HBoxContainer/VBoxContainerR/CenterContainer/SpaceRocket/LaunchFX
onready var stars_particles = $StarsParticles

var g1 = data.player.game1.completed
var g2 = data.player.game2.completed
var g3 = data.player.game3.completed
var g4 = data.player.game4.completed
var g5 = data.player.game5.completed

var launched = data.player.launched

func _ready():
	stars_particles.emitting = true

	check_lights()
	
	if launched:
		$HBoxContainer/VBoxContainerR/CenterContainer/SpaceRocket.hide()
	
	if is_rocket_ready() and not launched:
		launch_rocket()

func is_rocket_ready():
	return g1 and g2 and g3 and g4 and g5
	
func launch_rocket():
	data.player.launched = true
	data.save_data()
	rocket_animation.play("Launch")
	
func check_lights():
	if g1: $HBoxContainer/VBoxContainerR/Lights/Light1.set_texture(load("res://assets/sprites/menu/green_light.png"))
	if g2: $HBoxContainer/VBoxContainerR/Lights/Light2.set_texture(load("res://assets/sprites/menu/green_light.png"))
	if g3: $HBoxContainer/VBoxContainerR/Lights/Light3.set_texture(load("res://assets/sprites/menu/green_light.png"))
	if g4: $HBoxContainer/VBoxContainerR/Lights/Light4.set_texture(load("res://assets/sprites/menu/green_light.png"))
	if g5: $HBoxContainer/VBoxContainerR/Lights/Light5.set_texture(load("res://assets/sprites/menu/green_light.png"))
	
func _on_FundraisingButton_pressed():
	get_tree().change_scene("res://scenes/mini_games/fundraising/FundraisingGame.tscn")

func _on_TrainingCapabilitiesButton_pressed():
	get_tree().change_scene("res://scenes/mini_games/training_capabilities/TrainingCapabilitiesGame.tscn")

func _on_PolicyButton_pressed():
	get_tree().change_scene("res://scenes/mini_games/policy/PolicyGame.tscn")

func _on_DigitalToolsButton_pressed():
	get_tree().change_scene("res://scenes/mini_games/digital_tools/DigitalToolsGame.tscn")

func _on_ReachoutButton_pressed():
	get_tree().change_scene("res://scenes/mini_games/reachout/ReachoutGame.tscn")

func _on_About_pressed():
	get_tree().change_scene("res://scenes/About.tscn")

func _on_Options_pressed():
	get_tree().change_scene("res://scenes/Options.tscn")

func _on_Exit_pressed():
	get_tree().quit()
