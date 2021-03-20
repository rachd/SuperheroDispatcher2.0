extends "res://MapContainer/Map/Character.gd"

signal hero_selected(hero)
signal level_up(hero)
signal hero_info(hero)

export var id : int
var xp_threshold : int
var xp = 0

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
	self.connect("hero_selected", get_node("/root/MapContainer"), "_on_Hero_clicked")
	self.connect("level_up", get_node("/root/MapContainer"), "_on_Hero_level_up")
	
func initialize(_id):
	id = _id
	var hero_stats = constants.get_hero_stats()[id]
	set_stats(hero_stats)
	gameVariables.current_heros[id] = self

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
	gameVariables.update_total_xp(xp_added)
	var level_thresholds = constants.get_level_thresholds()
	if (xp_threshold < level_thresholds.size()):
		xp += xp_added
		if (xp > level_thresholds[xp_threshold]):
			xp -= level_thresholds[xp_threshold]
			xp_threshold += 1
			emit_signal("level_up", self)
			
func _on_AttackTimer_timeout():
	._on_AttackTimer_timeout()
	gameVariables.update_hero_damage_dealt(attack)
		
func take_damage(damage):
	.take_damage(damage)
	gameVariables.update_hero_damage_taken(damage)
