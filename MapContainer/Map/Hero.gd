extends "res://MapContainer/Map/Character.gd"

signal hero_selected(hero)
signal level_up(hero)
signal hero_info(hero)

export var id : int
var xp_threshold : int

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
	self.connect("level_up", get_node("/root/MapContainer"), "_on_Hero_level_up")
	
func initialize(_id):
	id = _id
	var hero_stats = constants.get_hero_stats()[id]
	hero_stats.xp = 0;
	set_stats(hero_stats)
	gameVariables.current_heros[id] = hero_stats

func start_attack(_target):
	.start_attack(_target)
	$XPTimer.start()

func _on_XPTimer_timeout():
	_increase_xp(2 * target.category)
	
func stop_attack():
	_increase_xp(10 * target.category)
	.stop_attack()
	$XPTimer.stop()
	
func _increase_xp(xp_added):
	gameVariables.current_heros[id].xp += xp_added
	if gameVariables.current_heros[id].xp > 100:
		pass
