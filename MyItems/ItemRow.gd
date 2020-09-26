extends VBoxContainer

signal equip_item(item)

var is_selected = false
var item_id
var item_type

func assign_item(itemId):
	var item = constants.get_item_by_id(itemId)
	item_id = item.id
	item_type = item.type
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
	
func _ready():
	self.connect("equip_item", get_node("/root/MyItems/Content/Heros"), "_on_item_equipped")


func _on_ItemRow_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if is_selected:
				_deselect_row()
			else:
				_select_row()


func _on_EquipButton_pressed():
	emit_signal("equip_item", item_id, item_type)
