extends VBoxContainer

signal hero_selected(heroId)
signal hero_deselected(heroId)

export var heroId: int

func _on_CheckButton_toggled(button_pressed):
	if button_pressed == true:
		emit_signal("hero_selected", heroId)
	else:
		emit_signal("hero_deselected", heroId)
		
func _populate_data():
	var hero_stats = constants.get_hero_stats()[heroId]
	$Name.text = "Name " + str(hero_stats["name"])
	$Speed.text = "Speed " + str(hero_stats["speed"])
	$Health.text = "Health " + str(hero_stats["health"])
	$Attack.text = "Attack " + str(hero_stats["attack"])

func _ready():
	_populate_data()
	self.connect("hero_selected", get_node("/root/HeroSelection"), "_on_Hero_seleted")
	self.connect("hero_deselected", get_node("/root/HeroSelection"), "_on_Hero_deseleted")