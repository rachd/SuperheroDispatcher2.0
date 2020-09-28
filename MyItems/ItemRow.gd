extends VBoxContainer

signal equip_item(item_id, item_type)
signal sell_item(item_id)

var is_selected = false
var is_equipped = false
var item_id
var item_type

func initialize(itemId):
	var item = constants.get_item_by_id(itemId)
	item_id = item.id
	item_type = item.type
	$HBoxContainer/VBoxContainer/TitleLabel.text = item.title;
	$TypeLabel.text = item.type
	$SalePriceLabel.text = "$" + str(item.salePrice)
	$HBoxContainer/VBoxContainer/HeroLabel.text = ""
	
func set_assigned_hero(hero_name):
	$HBoxContainer/VBoxContainer/HeroLabel.text = hero_name;
	
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
	$SalePriceLabel.show()
	is_selected = true
	
func _deselect_row():
	$EffectLabel.hide()
	$DescriptionLabel.hide()
	$TypeLabel.hide()
	$SalePriceLabel.hide()
	is_selected = false
	
func hide_if_type(itemType):
	if item_type == itemType:
		show()
	else:
		hide()
	
func _ready():
	self.connect("equip_item", get_node("/root/MyItems"), "_on_item_equipped")
	self.connect("sell_item", get_node("/root/MyItems"), "_on_item_sold")

func _on_ItemRow_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if is_selected:
				_deselect_row()
			else:
				_select_row()
				
func _on_EquipButton_pressed():
	emit_signal("equip_item", item_id, item_type)


func _on_SellButton_pressed():
	emit_signal("sell_item", item_id)
