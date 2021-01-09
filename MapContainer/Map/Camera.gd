extends Camera2D

var zoom_level = 0.5
var offset_x = 0
var offset_y = 0

func _input(event):
	if event.is_action_pressed("wheel_up"):
		if zoom_level > 0.25:
			zoom_level /= 2
			zoom = Vector2(zoom_level, zoom_level)
	elif event.is_action_pressed("wheel_down"):
		if zoom_level < 2:
			zoom_level *= 2
			zoom = Vector2(zoom_level, zoom_level)
	
	if event.is_action_pressed("up") or (event.is_pressed() and event.is_action("up")):
		offset_y -= 10
	if event.is_action_pressed("down") or (event.is_pressed() and event.is_action("down")):
		offset_y += 10
	if event.is_action_pressed("left") or (event.is_pressed() and event.is_action("left")):
		offset_x -= 10
	if event.is_action_pressed("right") or (event.is_pressed() and event.is_action("right")):
		offset_x += 10
	offset = Vector2(offset_x, offset_y)

func _ready():
	zoom = Vector2(zoom_level, zoom_level)
