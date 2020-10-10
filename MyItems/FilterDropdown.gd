extends OptionButton

signal show_all_items
signal filter_by_type(itemType)

func _ready():
	self.connect("show_all_items", get_node("/root/MyItems/Content/ItemList"), "_show_all_items")
	self.connect("filter_by_type", get_node("/root/MyItems/Content/ItemList"), "_filter_by_type")
	add_item("Filter", 0)
	add_item("Head", 1)
	add_item("Left Hand", 2)
	add_item("Right Hand", 3)
	add_item("Body", 4)
	add_item("Foot", 5)


func _on_FilterDropdown_item_selected(index):
	match index:
		0:
			emit_signal("show_all_items")
		1:
			emit_signal("filter_by_type", "head")
		2: 
			emit_signal("filter_by_type", "leftHand")
		3: 
			emit_signal("filter_by_type", "rightHand")
		4:
			emit_signal("filter_by_type", "body")
		5:
			emit_signal("filter_by_type", "foot")
