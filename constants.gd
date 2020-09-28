extends Node

static func get_hero_stats():
	return {
		1: {
			"name": "Zeus",
			"health": 100,
			"speed": 20,
			"attack": 60
		},
		2: {
			"name": "Hermes",
			"health": 70,
			"speed": 50,
			"attack": 40
		},
		3: {
			"name": "Artemis",
			"health": 80,
			"speed": 40,
			"attack": 50
		},
		4: {
			"name": "Poseidon",
			"health": 90,
			"speed": 30,
			"attack": 50
		}
	}
	
static func get_items():
	return [
	{
		"id": 0,
		"title": "really nice running sneakers",
		"type": "foot",
		"price": 80
	},
	{
		"id": 1,
		"title": "hoverboots",
		"type": "foot",
		"price": 5000
	},
	{
		"id": 2,
		"title": "test 1",
		"type": "foot",
		"price": 200
	},
	{
		"id": 3,
		"title": "test 2",
		"type": "head",
		"price": 1000
	},
	{
		"id": 4,
		"title": "test3",
		"type": "head",
		"price": 600
	},
	{
		"id": 5,
		"title": "test4",
		"type": "leftHand",
		"price": 1400
	},
	{
		"id": 6,
		"title": "test5",
		"type": "rightHand",
		"price": 1400
	},
	{
		"id": 7,
		"title": "test6",
		"type": "body",
		"price": 1400
	},
	{
		"id": 8,
		"title": "test7",
		"type": "body",
		"price": 1400
	},
	{
		"id": 9,
		"title": "test8",
		"type": "body",
		"price": 1400
	},
	{
		"id": 10,
		"title": "test9",
		"type": "rightHand",
		"price": 1400
	},
	{
		"id": 11,
		"title": "test10",
		"type": "head",
		"price": 1400
	}
	]
	
static func get_item_by_id(itemId):
	var items = get_items()
	for item in items:
		if item.id == itemId:
			return item
			
