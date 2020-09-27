extends VBoxContainer

var item_row_scene = preload("res://MyItems/ItemRow.tscn")
var item_rows = {}

func _ready():
	for owned_item_id in gameVariables.owned_item_ids:
		var item_row = item_row_scene.instance()
		item_row.initialize(owned_item_id)
		$ScrollContainer/ItemRowContainer.add_child(item_row)
		item_rows[owned_item_id] = item_row

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

func equip_item(itemId):
	item_rows[itemId].set_equipped()

func unequip_item(itemId):
	item_rows[itemId].set_unequipped()
