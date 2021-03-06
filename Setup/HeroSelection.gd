extends Control

var selected_heros = []

func _on_Hero_seleted(heroId):
	selected_heros.append(heroId)
	_set_button_disabled()
	
func _on_Hero_deseleted(heroId):
	selected_heros.erase(heroId)
	_set_button_disabled()
	
func _set_button_disabled():
	if selected_heros.size() == 3:
		$VBoxContainer/StartButton.disabled = false
	else:
		$VBoxContainer/StartButton.disabled = true

func _on_StartButton_pressed():
	gameVariables.selected_heros = selected_heros
	get_tree().change_scene("res://MapContainer/MapContainer.tscn")

