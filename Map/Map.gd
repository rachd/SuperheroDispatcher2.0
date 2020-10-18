extends Control

var selected_hero = null

func _calculate_new_path(start_position, target_position, hero):
	var start_road = $TileMap.closest_road(start_position)
	var end_road = $TileMap.closest_road(target_position)
	var road_path = $TileMap.calculate_path(start_road, end_road)
	hero.path = [start_road]
	if road_path:
		road_path.remove(0)
		var path = [start_road] + road_path + [target_position]
		hero.path = path

func _on_Hero_clicked(hero):
	selected_hero = hero

func _on_Map_clicked(position):
	if selected_hero:
		selected_hero.move_to_point(position)
		selected_hero = null
