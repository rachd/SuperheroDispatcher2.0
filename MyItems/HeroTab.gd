extends Control

signal hero_tab_selected(heroId)

export var heroId : int

func set_hero(id):
	heroId = id

func _ready():
	self.connect("hero_tab_selected", get_node("/root/MyItems/Content/Heros"), "_on_Hero_tab_selected")

func _on_TextureRect_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("hero_tab_selected", heroId)
