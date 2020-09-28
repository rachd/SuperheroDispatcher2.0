extends VBoxContainer

var selected_hero_id

func _on_Hero_tab_selected(heroId):
	selected_hero_id = heroId
	$Content/ItemList.on_hero_tab_selected(heroId)
	
func handle_equip(itemId, heroName, itemType):
	$Content/ItemList.equip_item(itemId, heroName)
	for hero in gameVariables.assigned_items.keys():
		if hero != selected_hero_id and gameVariables.assigned_items[hero].has(itemType) and gameVariables.assigned_items[hero][itemType] == itemId:
			gameVariables.assigned_items[hero].erase(itemType)

func _on_item_equipped(itemId, itemType):
	var hero_name = constants.get_hero_stats()[selected_hero_id].name
	if gameVariables.assigned_items.has(selected_hero_id):
		if gameVariables.assigned_items[selected_hero_id].has(itemType):
			$Content/ItemList.unequip_item(gameVariables.assigned_items[selected_hero_id][itemType])
			if gameVariables.assigned_items[selected_hero_id][itemType] == itemId:
				gameVariables.assigned_items[selected_hero_id].erase(itemType)
			else: 
				gameVariables.assigned_items[selected_hero_id][itemType] = itemId
				handle_equip(itemId, hero_name, itemType)
		else:
			gameVariables.assigned_items[selected_hero_id][itemType] = itemId
			handle_equip(itemId, hero_name, itemType)
	else:
		gameVariables.assigned_items[selected_hero_id] = {itemType: itemId}
		handle_equip(itemId, hero_name, itemType)
	$Content/Heros.on_item_equipped()
	
func _on_item_sold(itemId):
	var item = constants.get_item_by_id(itemId)
	gameVariables.budget += item.salePrice
	gameVariables.owned_item_ids.erase(itemId)
	for hero in gameVariables.assigned_items:
		if gameVariables.assigned_items[hero].has(item.type) and gameVariables.assigned_items[hero][item.type] == itemId:
			gameVariables.assigned_items[hero].erase(item.type)
	$Content/ItemList.remove_item(itemId)
	$Content/Heros.remove_item()
