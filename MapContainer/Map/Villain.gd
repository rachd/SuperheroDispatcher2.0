extends "res://MapContainer/Map/Character.gd"

signal villain_info(villain)
signal do_damage(attack, cell_type)
signal villain_selected(villain)
signal villain_dead(villain)

export var id : int

func initialize(_id):
	id = _id
	set_villain_stats()
	$AttackTimer.wait_time = speed / 10
	$AttackTimer.start()
	self.connect("villain_info", get_node("/root/MapContainer"), "_on_Villain_info")
	self.connect("do_damage", get_node("/root/MapContainer"), "_on_Villain_do_damage")
	self.connect("villain_dead", get_node("/root/MapContainer/Map/VillainSpawner"), "_on_Villain_dead")
	
func set_villain_stats():
	var villain_stats = constants.get_villain_stats()[id]
	set_stats(villain_stats)

func take_damage(damage):
	current_health -= damage
	$Label.text = str(current_health)
	if (current_health <= 0):
		_die()

func on_right_click():
	emit_signal("villain_info", self)
	
func _ready():
	._ready()
				
func _die():
	emit_signal("villain_dead", self, target)
	
func _on_AttackTimer_timeout():
	if (target):
		target.take_damage(attack)
	else:
		var position = self.position
		var tilemap = get_node("/root/MapContainer/Map/TileMap")
		var cell_coord = tilemap.world_to_map(position)
		var cell_type_id = tilemap.get_cellv(cell_coord)
		emit_signal("do_damage", attack, cell_type_id)
