extends VBoxContainer

signal hero_selected(heroId)
signal hero_deselected(heroId)

var heroId = 1

func _on_CheckButton_toggled(button_pressed):
	if button_pressed == true:
		emit_signal("hero_selected", heroId)
	else:
		emit_signal("hero_deselected", heroId)

func _ready():
	self.connect("hero_selected", get_node("/root/HeroSelection"), "_on_Hero_seleted")
	self.connect("hero_deselected", get_node("/root/HeroSelection"), "_on_Hero_deseleted")