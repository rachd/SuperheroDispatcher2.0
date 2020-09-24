extends VBoxContainer

var item = {}

signal item_bought(item, item_card)
signal item_saved(item)

func set_data(i):
	item = i
	$TitleLabel.text = item.title
	$TypeLabel.text = item.type
	$PriceLabel.text = "$" + str(item.price)
	
func disable():
	$TitleLabel.text = ""
	$TypeLabel.text = ""
	$PriceLabel.text = ""
	$Description.text = ""
	$BuyButton.visible = false
	$SaveButton.visible = false
	$TextureRect.visible = false
	
func _ready():
	self.connect("item_bought", get_node("/root/Store"), "_on_item_bought")
	self.connect("item_saved", get_node("/root/Store"), "_on_item_saved")

func _on_BuyButton_pressed():
	emit_signal("item_bought", item, self)


func _on_SaveButton_pressed():
	emit_signal("item_saved", item)
