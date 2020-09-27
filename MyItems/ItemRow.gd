extends VBoxContainer

signal equip_item(item)

var is_selected = false
var is_equipped = false
var item_id
var item_type

func initialize(itemId):
	var item = constants.get_item_by_id(itemId)
	item_id = item.id
	item_type = item.type
	$HBoxContainer/TitleLabel.text = item.title;
	$TypeLabel.text = item.type
	
func set_unequipped():
	is_equipped = false
	$HBoxContainer/EquipButton.text = "Equip"
	
func set_equipped():
	is_equipped = true
	$HBoxContainer/EquipButton.text = "Unequip"

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
	self.connect("equip_item", get_node("/root/MyItems"), "_on_item_equipped")

func _on_ItemRow_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if is_selected:
				_deselect_row()
			else:
				_select_row()
				
func _on_EquipButton_pressed():
	emit_signal("equip_item", item_id, item_type)
