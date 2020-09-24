extends VBoxContainer

var hero_tab_scene = preload("res://MyItems/HeroTab.tscn")

func _ready():
	for selected_hero in gameVariables.selected_heros:
		var tab = hero_tab_scene.instance()
		tab.set_hero(selected_hero)
		$HeroTabs.add_child(tab)

func _on_Hero_tab_selected(heroId):
	$HeroPanel.show_hero(heroId)
