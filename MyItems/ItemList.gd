extends VBoxContainer

var item_row_scene = preload("res://MyItems/ItemRow.tscn")
var item_rows = {}

func _ready():
	for owned_item_id in gameVariables.owned_item_ids:
		var item_row = item_row_scene.instance()
		item_row.initialize(owned_item_id)
		$ScrollContainer/ItemRowContainer.add_child(item_row)
		item_rows[owned_item_id] = item_row
		_initialize_assignments()

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

func unequip_item(itemId):
	item_rows[itemId].set_unequipped()
	item_rows[itemId].set_assigned_hero("")
	
func remove_item(itemId):
	item_rows[itemId].queue_free()
	item_rows.erase(itemId)
	
func _show_all_items():
	for item_row in item_rows.values():
		item_row.show()
		
func _filter_by_type(itemType):
	for item_row in item_rows.values():
		item_row.hide_if_type(itemType)

func _show_unequipped_items():
	_show_all_items()
	var assigned_items = []
	for hero in gameVariables.assigned_items.keys():
		assigned_items += gameVariables.assigned_items[hero].values()
	for item_id in gameVariables.owned_item_ids:
		if item_id in assigned_items:
			item_rows[item_id].hide()
