extends VBoxContainer

var panel_row_scene = preload("res://MapContainer/RightPanelRow.tscn")

var panels = {}

func _ready():
	var active_heros = gameVariables.current_heros.keys()
	for hero_id in active_heros:
		var row = panel_row_scene.instance()
		row.display_hero(hero_id)
		panels[hero_id] = row
		add_child(row)

func _on_Hero_clicked(hero):
	panels[hero.id].set_active()
	
func _on_Map_clicked():
	for panel in panels.values():
		panel.set_inactive()
