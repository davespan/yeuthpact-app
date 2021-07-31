extends TextureRect

var value

func init(id, sprite):
	value = id
	texture = sprite
	rect_scale = Vector2(.6, .6)

func get_drag_data(position):
	var tr = TextureRect.new()
	tr.texture = texture
	tr.rect_scale = Vector2(.4, .4)
	set_drag_preview(tr)
	return value
