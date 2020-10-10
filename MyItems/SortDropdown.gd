extends OptionButton

signal items_sorted

func _ready():
	self.connect("items_sorted", get_node("/root/MyItems/Content/ItemList"), "_on_items_sorted")
	add_item("Alpha Asc", 0)
	add_item("Alpha Dsc", 1)
	add_item("Type Asc", 2)
	add_item("Type Dsc", 3)
	add_item("Sale Price Asc", 4)
	add_item("Sale Price Dsc", 5)
	
func _alpha_asc(a, b):
	var item_a = constants.get_item_by_id(a)
	var item_b = constants.get_item_by_id(b)
	return item_a.title < item_b.title
	
func _alpha_dsc(a, b):
	var item_a = constants.get_item_by_id(a)
	var item_b = constants.get_item_by_id(b)
	return item_a.title > item_b.title
	
func _type_asc(a, b):
	var item_a = constants.get_item_by_id(a)
	var item_b = constants.get_item_by_id(b)
	return item_a.type < item_b.type
	
func _type_dsc(a, b):
	var item_a = constants.get_item_by_id(a)
	var item_b = constants.get_item_by_id(b)
	return item_a.type > item_b.type

func _sale_price_asc(a, b):
	var item_a = constants.get_item_by_id(a)
	var item_b = constants.get_item_by_id(b)
	return item_a.salePrice < item_b.salePrice
	
func _sale_price_dsc(a, b):
	var item_a = constants.get_item_by_id(a)
	var item_b = constants.get_item_by_id(b)
	return item_a.salePrice > item_b.salePrice

func _on_SortDropdown_item_selected(index):
	match index:
		0:
			gameVariables.owned_item_ids.sort_custom(self, "_alpha_asc")
		1: 
			gameVariables.owned_item_ids.sort_custom(self, "_alpha_dsc")
		2:
			gameVariables.owned_item_ids.sort_custom(self, "_type_asc")
		3: 
			gameVariables.owned_item_ids.sort_custom(self, "_type_dsc")
		4:
			gameVariables.owned_item_ids.sort_custom(self, "_sale_price_asc")
		5: 
			gameVariables.owned_item_ids.sort_custom(self, "_sale_price_dsc")
	emit_signal("items_sorted")
