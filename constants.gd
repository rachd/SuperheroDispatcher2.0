extends Node

static func get_hero_stats():
	return {
		1: {
			"title": "Zeus",
			"health": 100,
			"speed": 20,
			"attack": 60,
			"icon": "icon"
		},
		2: {
			"title": "Hermes",
			"health": 70,
			"speed": 50,
			"attack": 40,
			"can_fly": true,
			"icon": "icon"
		},
		3: {
			"title": "Artemis",
			"health": 80,
			"speed": 40,
			"attack": 50,
			"icon": "icon"
		},
		4: {
			"title": "Poseidon",
			"health": 90,
			"speed": 30,
			"attack": 50,
			"icon": "icon"
		},
		5: {
			"title": "Martharon",
			"health": 80,
			"speed": 50,
			"attack": 30,
			"icon": "martha_ron"
		}
	}
	
static func get_villain_stats():
	return {
		1: {
			"title": "Medusa",
			"health": 40,
			"attack": 10,
			"speed": 20,
			"category": 1,
			"icon": "icon"
		},
		2: {
			"title": "Minotaur",
			"health": 80,
			"attack": 40,
			"speed": 50,
			"category": 2,
			"icon": "icon"
		},
		3: {
			"title": "The Bookworm",
			"health": 150,
			"attack": 50,
			"speed": 60,
			"category": 4,
			"icon": "icon"
		}
	}
	
static func get_items():
	return [
	{
		"id": 0,
		"title": "really nice running sneakers",
		"type": "foot",
		"price": 80,
		"salePrice": 405
	},
	{
		"id": 1,
		"title": "hoverboots",
		"type": "foot",
		"price": 5000,
		"salePrice": 2500
	},
	{
		"id": 2,
		"title": "test 1",
		"type": "foot",
		"price": 200,
		"salePrice": 100
	},
	{
		"id": 3,
		"title": "test 2",
		"type": "head",
		"price": 1000,
		"salePrice": 500
	},
	{
		"id": 4,
		"title": "test3",
		"type": "head",
		"price": 600,
		"salePrice": 300
	},
	{
		"id": 5,
		"title": "test4",
		"type": "leftHand",
		"price": 1400,
		"salePrice": 700
	},
	{
		"id": 6,
		"title": "test5",
		"type": "rightHand",
		"price": 1400,
		"salePrice": 700
	},
	{
		"id": 7,
		"title": "test6",
		"type": "body",
		"price": 1400,
		"salePrice": 700
	},
	{
		"id": 8,
		"title": "test7",
		"type": "body",
		"price": 1400,
		"salePrice": 700
	},
	{
		"id": 9,
		"title": "test8",
		"type": "body",
		"price": 1400,
		"salePrice": 700
	},
	{
		"id": 10,
		"title": "test9",
		"type": "rightHand",
		"price": 1400,
		"salePrice": 700
	},
	{
		"id": 11,
		"title": "test10",
		"type": "head",
		"price": 1400,
		"salePrice": 700
	}
	]
	
static func get_item_by_id(itemId):
	var items = get_items()
	for item in items:
		if item.id == itemId:
			return item
			
static func get_cell_size():
	return 32
	
static func get_level_thresholds():
	return [100, 500, 1000, 2000]
	
static func get_tile_id_by_name(tile_name):
	match tile_name:
		"high_income":
			return 0
		"low_income":
			return 1
		"office":
			return 2
		"industrial":
			return 3
		"road":
			return 4

static func get_tile_worth_by_id(tile_id):
	match tile_id:
		0:
			return 40
		1:
			return 20
		2:
			return 30
		3:
			return 10
		4:
			return 0
