extends Timer

onready var progress_bar = $CountdownBar
onready var seconds = self.wait_time

func _ready():
	progress_bar.value = seconds
	
func _process(delta):
	progress_bar.value = self.time_left
