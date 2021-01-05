extends Control

var DISTRICT_WIDTH = 50
var DISTRICT_HEIGHT = 50

onready var Map = $TileMap

var rng = RandomNumberGenerator.new()
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
		
func _get_tile_id_by_name(tile_name):
	if tile_name == "high_income":
		return 0
	elif tile_name == "low_income":
		return 1
	elif tile_name == "office":
		return 2
	elif tile_name == "industrial":
		return 3
	elif tile_name == "road":
		return 4
		
func _get_neighbors(tiles, x, y):
	var road_id = _get_tile_id_by_name("road")
	# [upper left, upper middle, upper right, left]
	var neighbors = [road_id, road_id, road_id, road_id]
	# row above
	if x > 0:
		if y > 0:
			neighbors[0] = tiles[x - 1][y - 1]
		neighbors[1] = tiles[x - 1][y]
		if y + 1 < DISTRICT_WIDTH:
			neighbors[2] = tiles[x - 1][y + 1]
	# current row
	if y > 0:
		neighbors[3] = tiles[x][y - 1]
	return neighbors
		
func _choose_next_tile(neighbors):
	var road_id = _get_tile_id_by_name("road")
	if neighbors[0] == road_id:
		if neighbors[1] == road_id:
			if neighbors[2] == road_id:
				if neighbors[3] == road_id:
					return _choose_random_building_tile()
				else:
					return _choose_random_tile()
			else:
				if neighbors[3] == road_id:
					return _choose_random_building_tile()
				else:
					return _choose_random_tile() 
		else:
			if neighbors[2] == road_id:
				if neighbors[3] == road_id:
					return _choose_random_tile()
				else:
					return _choose_random_building_tile()
			else:
				if neighbors[3] == road_id:
					return _choose_random_building_tile()
				else:
					return _choose_random_building_tile()
	else:
		if neighbors[1] == road_id:
			if neighbors[2] == road_id:
				if neighbors[3] == road_id:
					return road_id
				else:
					return road_id
			else:
				if neighbors[3] == road_id:
					return road_id
				else:
					return road_id
		else:
			if neighbors[2] == road_id:
				if neighbors[3] == road_id:
					return road_id
				else:
					return _choose_random_building_tile()
			else:
				if neighbors[3] == road_id:
					return _choose_random_tile()
				else:
					return _choose_random_tile()		
								
func _choose_random_tile():
	return rng.randi_range(0, 4)
					
func _choose_random_building_tile():
	return rng.randi_range(0, 3)

func _generate_district():
	Map.clear()
	var tiles = []
	for x in range(DISTRICT_HEIGHT):
		tiles.append([])
		for y in range(DISTRICT_WIDTH):
			var neighbors = _get_neighbors(tiles, x, y)
			var tile_value = _choose_next_tile(neighbors)
			tiles[x].append(tile_value)
			Map.set_cellv(Vector2(x, y), tile_value)

func _ready():
	rng.randomize()
	_generate_district()
