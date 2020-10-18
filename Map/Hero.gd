extends "res://Map/Character.gd"

signal hero_selected(hero)

export var id : int

func _handle_overlap(overlap):
	if overlap.has_method("start_hero_interaction"):
		overlap.start_hero_interaction(self)

func on_click():
	emit_signal("hero_selected", self)
	
func _ready():
	._ready()
	self.connect("hero_selected", get_node("/root/MapContainer"), "_on_Hero_clicked")

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		on_click()
		get_tree().set_input_as_handled()
