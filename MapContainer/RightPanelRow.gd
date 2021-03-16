extends VBoxContainer

var id

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
