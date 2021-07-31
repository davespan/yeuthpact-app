extends Area2D

signal pickup

var coin = 'res://assets/sprites/fundraising_game/coin.png'
var dissemination = 'res://assets/sprites/fundraising_game/dissemination.png'
var planning = 'res://assets/sprites/fundraising_game/planning.png'
var engagement = 'res://assets/sprites/fundraising_game/engagement.png'

# Pickup table
var textures = {0: coin,
				1: coin,
				2: coin,
				3: coin,
				4: coin,
				5: dissemination,
				6: dissemination,
				7: planning,
				8: planning,
				9: planning,
				10: engagement}

var timer

func init(type, pos):
	timer = $TTL
	if type in range(0, 5):
		timer.set_wait_time(4.8)
	elif type in range(5, 7):
		timer.set_wait_time(4.5)
	elif type in range(7, 10):
		timer.set_wait_time(4.2)
	elif type == 10:
		timer.set_wait_time(3.8)
	timer.connect("timeout", self, "_on_timer_timeout")
	timer.start()
	
	$Sprite.texture = load(textures[type])
	position = pos

func _on_Pickup_body_entered(_body):
	emit_signal('pickup')
	queue_free()
	
func _on_start_game():
	queue_free()
	
func _on_timer_timeout():
	queue_free()
