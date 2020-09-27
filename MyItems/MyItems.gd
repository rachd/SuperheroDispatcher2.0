extends VBoxContainer

var selected_hero_id

func _on_Hero_tab_selected(heroId):
	selected_hero_id = heroId
	$Content/ItemList.on_hero_tab_selected(heroId)

func _on_item_equipped(itemId, itemType):
	if gameVariables.assigned_items.has(selected_hero_id):
		if gameVariables.assigned_items[selected_hero_id].has(itemType):
			$Content/ItemList.unequip_item(gameVariables.assigned_items[selected_hero_id][itemType])
			if gameVariables.assigned_items[selected_hero_id][itemType] == itemId:
				gameVariables.assigned_items[selected_hero_id].erase(itemType)
			else: 
				gameVariables.assigned_items[selected_hero_id][itemType] = itemId
				$Content/ItemList.equip_item(itemId)
		else:
			gameVariables.assigned_items[selected_hero_id][itemType] = itemId
			$Content/ItemList.equip_item(itemId)
	else:
		gameVariables.assigned_items[selected_hero_id] = {itemType: itemId}
		$Content/ItemList.equip_item(itemId)
	$Content/Heros.on_item_equipped()
