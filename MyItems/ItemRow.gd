extends VBoxContainer

var is_selected = false

func select_row():
	$EffectLabel.show()
	$DescriptionLabel.show()
	$TypeLabel.show()
	is_selected = true
	
func deselect_row():
	$EffectLabel.hide()
	$DescriptionLabel.hide()
	$TypeLabel.hide()
	is_selected = false


func _on_ItemRow_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if is_selected:
				deselect_row()
			else:
				select_row()
