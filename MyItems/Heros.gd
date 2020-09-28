extends VBoxContainer

signal hero_tab_changed(heroId)

var hero_tab_scene = preload("res://MyItems/HeroTab.tscn")
var selected_hero_id

func _ready():
	self.connect("hero_tab_changed", get_node("/root/MyItems"), "_on_Hero_tab_selected")
	for selected_hero in gameVariables.selected_heros:
		var tab = hero_tab_scene.instance()
		tab.set_hero(selected_hero)
		$HeroTabs.add_child(tab)
	_handle_hero_change(gameVariables.selected_heros[0])
	
func _handle_hero_change(heroId):
	selected_hero_id = heroId
	$HeroPanel.show_hero(selected_hero_id)
	emit_signal("hero_tab_changed", heroId)

func _on_Hero_tab_selected(heroId):
	_handle_hero_change(heroId)

func on_item_equipped():
	$HeroPanel.display_items(selected_hero_id)
	
func remove_item():
	_handle_hero_change(selected_hero_id)
