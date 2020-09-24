extends Control

signal start_next_day(budget)

var rng = RandomNumberGenerator.new()
var item_card_scene = preload("res://ShopCard.tscn")

var items = []
var budget = 0

var MAX_ITEMS = 6

func set_budget(b):
	budget = b
	$VBoxContainer/BudgetLabel.text = "Budget: $" + str(budget)
	
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
	for item in all_items:
		if selected_item_ids.has(item.id):
			items.append(item)

func _add_item_cards():
	var shop_cards = $VBoxContainer/MarginContainer/ItemContainer.get_children()
	for i in range(0, shop_cards.size()):
		shop_cards[i].set_data(items[i])
		
func _on_item_bought(item, item_card):
	if item.price <= budget:
		gameVariables.unassigned_items.append(item)
		gameVariables.owned_item_ids.append(item.id)
		budget -= item.price
		set_budget(budget)
		item_card.disable()
	
func _on_item_saved(item):
	gameVariables.saved_items.append(item)
	
func _ready():
	#self.connect("start_next_day", get_node("/root/Main"), "_on_close_Store")
	rng.randomize()
	set_budget(10000)
	items = gameVariables.saved_items
	gameVariables.saved_items = []
	self._select_items(MAX_ITEMS - items.size())
	self._add_item_cards()

#func _on_Done_pressed():
	#emit_signal("start_next_day", budget)
