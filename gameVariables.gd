extends Node

var selected_heros = []
var day = 1
var budget = 1000000
var saved_items = []
var owned_item_ids = []
var assigned_items = {}
var show_new_shop = true
var current_shop = {}
var current_heros = {}

#trackers
var hero_damage_taken = 0
var hero_damage_dealt = 0
var property_damage = 0
var total_xp = 0
var villains_defeated = 0

func update_hero_damage_taken(delta):
	hero_damage_taken += delta

func update_hero_damage_dealt(delta):
	hero_damage_dealt += delta
	
func update_property_damage(delta):
	property_damage += delta
	
func update_total_xp(delta):
	total_xp += delta

func update_villains_defeated():
	villains_defeated += 1

#events
var villain_events = [1, 2]
func add_events_for_hero(hero_id):
	match hero_id:
		5:
			villain_events.push_back(3)
