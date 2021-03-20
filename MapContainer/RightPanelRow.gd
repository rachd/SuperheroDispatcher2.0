extends VBoxContainer

var id
var is_active

func display_hero(_id):
	id = _id
	var hero = gameVariables.current_heros[_id]
	$HBoxContainer/VBoxContainer/TitleLabel.text = hero.title
	$HBoxContainer/VBoxContainer/HealthLabel.text = "Health %d" % [hero.health]
	$HBoxContainer/VBoxContainer/SpeedLabel.text = "Speed %d" % [hero.speed]
	$HBoxContainer/VBoxContainer/AttackLabel.text = "Attack %d" % [hero.attack]
	$HBoxContainer/VBoxContainer/PowersLabel.text = "Powers: %s" % "Flight" if hero.can_fly else ""
	$HBoxContainer/VBoxContainer/ProgressBar.value = hero.xp
	$LevelLabel.text = "Level %d" % hero.xp_threshold
	$HBoxContainer/Icon.texture = load("res://assets/" + hero.icon + ".png")


func _on_RefreshTimer_timeout():
	display_hero(id)

func set_active():
	margin_left = 3
	margin_right = 3
	is_active = true

func set_inactive():
	margin_left = 0
	margin_right = 0
	is_active = false


func _on_RightPanelRow_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if is_active:
				set_inactive()
				is_active = false
			else:
				set_active()
				is_active = true
