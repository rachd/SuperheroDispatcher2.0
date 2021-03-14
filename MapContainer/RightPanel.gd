extends VBoxContainer

var panel_row_scene = preload("res://MapContainer/RightPanelRow.tscn")

func _ready():
	var active_heros = gameVariables.current_heros.keys()
	for hero_id in active_heros:
		var row = panel_row_scene.instance()
		row.display_hero(hero_id)
		add_child(row)
