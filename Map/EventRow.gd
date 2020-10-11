extends HBoxContainer

signal show_event_entity(entity)

var entity

func _ready():
	self.connect("show_event_entity", get_node("/root/MapContainer"), "_display_event_entity")
	
func initialize(_entity):
	entity = _entity
	$EntityLabel.text = entity.title

func _on_EventRow_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("show_event_entity", entity)
