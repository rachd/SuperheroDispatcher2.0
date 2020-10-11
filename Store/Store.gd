extends Control

signal start_next_day(budget)

var rng = RandomNumberGenerator.new()
var item_card_scene = preload("res://Store/ShopCard.tscn")

var items = []

var MAX_ITEMS = 6

func set_budget(b):
	$VBoxContainer/HBoxContainer/VBoxContainer/BudgetLabel.text = "Budget: $" + str(b)
	
func reset():
	self.queue_free()

func _select_items(num_to_select):
	var all_items = constants.get_items()
	var selected_item_ids = []
	for saved_item in gameVariables.saved_items:
		selected_item_ids.append(saved_item.id)
	var owned_item_ids = gameVariables.owned_item_ids
	while selected_item_ids.size() < num_to_select:
		var item_index = rng.randi_range(0, all_items.size()-1)
		var item_id = all_items[item_index].id
		while selected_item_ids.has(item_id) || owned_item_ids.has(item_id):
			item_index = rng.randi_range(0, all_items.size()-1)
			item_id = all_items[item_index].id
		selected_item_ids.append(item_id)
		items.append(constants.get_item_by_id(item_id))
		gameVariables.current_shop[item_id] = true

func _add_item_cards(disabledItems):
	var shop_cards = $VBoxContainer/MarginContainer/ItemContainer.get_children()
	for i in range(0, shop_cards.size()):
		shop_cards[i].set_data(items[i])
		if items[i].id in disabledItems:
			shop_cards[i].disable()
		
func _on_item_bought(item, item_card):
	if item.price <= gameVariables.budget:
		gameVariables.owned_item_ids.append(item.id)
		gameVariables.budget -= item.price
		set_budget(gameVariables.budget)
		item_card.disable()
		gameVariables.current_shop[item.id] = false
	
func _on_item_saved(item):
	gameVariables.saved_items.append(item)
	
func _ready():
	var disabled_items = []
	set_budget(gameVariables.budget)
	if gameVariables.show_new_shop:
		rng.randomize()
		items = gameVariables.saved_items
		gameVariables.saved_items = []
		self._select_items(MAX_ITEMS - items.size())
	else:
		var item_ids = gameVariables.current_shop.keys()
		for item_id in item_ids:
			items.append(constants.get_item_by_id(item_id))
			if gameVariables.current_shop[item_id] == false:
				disabled_items.append(item_id)
	self._add_item_cards(disabled_items)
	gameVariables.show_new_shop = false

func _on_MyItemsButton_pressed():
	get_tree().change_scene("res://MyItems/MyItems.tscn")


func _on_DoneButton_pressed():
	get_tree().change_scene("res://Map/MapContainer.tscn")
