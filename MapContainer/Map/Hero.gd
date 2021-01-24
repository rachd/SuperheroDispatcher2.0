extends "res://MapContainer/Map/Character.gd"

signal hero_selected(hero)
signal hero_info(hero)

export var id : int

func _handle_overlap(overlap):
	if overlap.get_parent().has_method("start_hero_interaction"):
		overlap.get_parent().start_hero_interaction(self)

func on_click():
	emit_signal("hero_selected", self)
	
func on_right_click():
	emit_signal("hero_info", self)
	
func _ready():
	._ready()
	self.connect("hero_info", get_node("/root/MapContainer"), "_on_Hero_info")
	self.connect("hero_selected", get_node("/root/MapContainer/Map"), "_on_Hero_clicked")
	
func initialize(_id):
	id = _id
	var hero_stats = constants.get_hero_stats()[id]
	set_stats(hero_stats)
