extends Area2D

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		get_parent().on_click()
		get_tree().set_input_as_handled()
