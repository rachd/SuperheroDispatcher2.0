extends "res://MapContainer/Map/Character.gd"

signal villain_info(villain)

export var id : int

func initialize(_id):
	id = _id

func on_right_click():
	emit_signal("villain_info", self)
	
func _ready():
	._ready()
	self.connect("villain_info", get_node("/root/MapContainer"), "_on_Villain_info")