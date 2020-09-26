extends VBoxContainer

var hero_tab_scene = preload("res://MyItems/HeroTab.tscn")
var selected_hero_id

func _ready():
	for selected_hero in gameVariables.selected_heros:
		var tab = hero_tab_scene.instance()
		tab.set_hero(selected_hero)
		$HeroTabs.add_child(tab)
	selected_hero_id = gameVariables.selected_heros[0]
	$HeroPanel.show_hero(selected_hero_id)

func _on_Hero_tab_selected(heroId):
	selected_hero_id = heroId
	$HeroPanel.show_hero(heroId)

func _on_item_equipped(itemId, itemType):
	if gameVariables.assigned_items.has(selected_hero_id):
		if gameVariables.assigned_items[selected_hero_id].has(itemType):
			#trigger deselect event for prior item
			pass	
		gameVariables.assigned_items[selected_hero_id][itemType] = itemId
	else:
		gameVariables.assigned_items[selected_hero_id] = {itemType: itemId}
	$HeroPanel.display_items()
