extends VBoxContainer

var event_row_scene = preload("res://MapContainer/EventRow.tscn")

var event_rows = []

func add_event(event):
	var event_row = event_row_scene.instance()
	event_row.initialize(event)
	add_child(event_row)
	move_child(event_row, 1)
	event_rows.append(event_row)
	if len(event_rows) > 5:
		event_rows[0].queue_free()
		event_rows = event_rows.slice(1, 5)
