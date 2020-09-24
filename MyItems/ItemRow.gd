extends VBoxContainer

var is_selected = false

func assign_item(itemId):
	var item = constants.get_item_by_id(itemId)
	$HBoxContainer/TitleLabel.text = item.title;
	$TypeLabel.text = item.type

func _select_row():
	$EffectLabel.show()
	$DescriptionLabel.show()
	$TypeLabel.show()
	is_selected = true
	
func _deselect_row():
	$EffectLabel.hide()
	$DescriptionLabel.hide()
	$TypeLabel.hide()
	is_selected = false

func _on_ItemRow_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if is_selected:
				_deselect_row()
			else:
				_select_row()
