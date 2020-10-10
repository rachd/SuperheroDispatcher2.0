extends VBoxContainer

var item_row_scene = preload("res://MyItems/ItemRow.tscn")
var item_rows = {}
var current_filter = null
var show_equipped = true

func _render_items():
	for owned_item_id in gameVariables.owned_item_ids:
		var item_row = item_row_scene.instance()
		item_row.initialize(owned_item_id)
		$ScrollContainer/ItemRowContainer.add_child(item_row)
		item_rows[owned_item_id] = item_row
		_initialize_assignments()
		
func _ready():
	_render_items()

func _initialize_assignments():
	var assigned_items = gameVariables.assigned_items
	for hero_id in assigned_items:
		var hero_name = constants.get_hero_stats()[hero_id].name
		for item_id in assigned_items[hero_id].values():
			item_rows[item_id].set_assigned_hero(hero_name)

func on_hero_tab_selected(heroId):
	if gameVariables.assigned_items.has(heroId):
		var equipped_items = gameVariables.assigned_items[heroId].values()
		for item_id in item_rows.keys():
			if item_id in equipped_items:
				item_rows[item_id].set_equipped()
			else:
				item_rows[item_id].set_unequipped()
	else:
		for item_row in item_rows.values():
			item_row.set_unequipped()

func equip_item(itemId, heroId):
	item_rows[itemId].set_equipped()
	item_rows[itemId].set_assigned_hero(heroId)
	if not show_equipped:
		item_rows[itemId].hide()

func unequip_item(itemId):
	item_rows[itemId].set_unequipped()
	item_rows[itemId].set_assigned_hero("")
	
func remove_item(itemId):
	item_rows[itemId].queue_free()
	item_rows.erase(itemId)
	
func _show_all_items():
	current_filter = null
	for item_row in item_rows.values():
		item_row.show()
	if !show_equipped:
		_hide_equipped()
		
func _filter_by_type(itemType):
	current_filter = itemType
	for item_row in item_rows.values():
		item_row.hide_if_type(itemType)
	if !show_equipped:
		_hide_equipped()
	
			
func _on_items_sorted():
	for item_row in item_rows.values():
		item_row.queue_free()
	_render_items()


func _on_UnequppedCheckBox_toggled(button_pressed):
	if button_pressed:
		_hide_equipped()
	else:
		_show_equipped()
	
func _hide_equipped():
	show_equipped = false
	var assigned_items = []
	for hero in gameVariables.assigned_items.keys():
		assigned_items += gameVariables.assigned_items[hero].values()
	for item_id in gameVariables.owned_item_ids:
		if item_id in assigned_items:
			item_rows[item_id].hide()
			
func _show_equipped():
	show_equipped = true
	if current_filter == null:
		_show_all_items()
	else:
		_filter_by_type(current_filter)
			
