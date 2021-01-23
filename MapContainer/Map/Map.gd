extends Control

signal map_clicked

var DISTRICT_WIDTH = 50
var DISTRICT_HEIGHT = 50

onready var Map = $TileMap
var hero_scene = preload("res://MapContainer/Map/Hero.tscn")

var rng = RandomNumberGenerator.new()
var active_hero = null

func _on_Hero_clicked(hero):
	if !active_hero:
		active_hero = hero
		
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
								
func _choose_random_tile():
	return rng.randi_range(0, 4)
					
func _choose_random_building_tile():
	return rng.randi_range(0, 3)
	
func _generate_road_indexes(max_size):
	var current_row = -1
	var road_rows = []
	while current_row < max_size:
		current_row += rng.randi_range(3, 5)
		road_rows.append(current_row)
	return road_rows

func _generate_district():
	Map.clear()
	var road_id = _get_tile_id_by_name("road")
	var road_rows = _generate_road_indexes(DISTRICT_HEIGHT)
	var road_cols = _generate_road_indexes(DISTRICT_WIDTH)
	for x in range(DISTRICT_HEIGHT):
		for y in range(DISTRICT_WIDTH):
			if road_rows.has(x) or road_cols.has(y):
				Map.set_cellv(Vector2(x, y), road_id)
			else:
				Map.set_cellv(Vector2(x, y), _choose_random_building_tile())
	$TileMap.initialize()
				
func _generate_heros():
	for hero_id in gameVariables.selected_heros:
		var hero = hero_scene.instance()
		hero.initialize(hero_id)
		add_child(hero)
		
func _on_Map_clicked(target_position):
	emit_signal("map_clicked")
	if active_hero:
		var start_position = active_hero.position
		var start_road = $TileMap.closest_road(start_position, target_position)
		var end_road = $TileMap.closest_road(target_position, start_position)
		var road_path = $TileMap.calculate_path(start_road, end_road)
		active_hero.path = [start_road]
		if road_path:
			road_path.remove(0)
			var path = [start_road] + road_path + [target_position]
			active_hero.path = path
			active_hero = null
		
func _ready():
	rng.randomize()
	_generate_district()
	_generate_heros()
	self.connect("map_clicked", get_node("/root/MapContainer"), "_on_Map_clicked")
