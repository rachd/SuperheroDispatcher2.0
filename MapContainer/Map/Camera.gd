extends Camera2D

var zoom_level = 0.5
var offset_x = 0
var offset_y = 0

func _zoom_at_point(zoom_change, point):
	var c0 = global_position
	var v0 = get_viewport().size
	var c1 # next camera position
	var z0 = zoom
	var z1 = z0 * zoom_change

	c1 = c0 + (-0.5*v0 + point)*(z0 - z1)
	zoom = z1
	global_position = c1

func _input(event):
	if event.is_action_pressed("wheel_up"):
		if zoom_level > 0.25:
			_zoom_at_point(0.5, event.position)
	elif event.is_action_pressed("wheel_down"):
		if zoom_level < 2:
			_zoom_at_point(2, event.position)
	
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
