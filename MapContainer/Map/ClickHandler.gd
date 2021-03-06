extends Area2D

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		if get_parent().has_method("on_click"):
			get_parent().on_click()
		get_tree().set_input_as_handled()
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT and event.pressed:
		if get_parent().has_method("on_right_click"):
			get_parent().on_right_click()
		get_tree().set_input_as_handled()
