extends Camera

onready var player = get_parent()
var offset

func _init():
	set_as_toplevel(true)

func _ready():
	offset = get_global_transform().origin

func _physics_process(delta):
	if not player.is_dead:
		var target = player.get_global_transform().origin
		var base = get_global_transform().basis
		set_global_transform(Transform(base, target + offset))
