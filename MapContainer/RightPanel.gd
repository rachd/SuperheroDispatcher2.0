extends VBoxContainer

func display_hero(id):
	var hero = gameVariables.current_heros[id]
	$TitleLabel.text = hero.title
	$HealthLabel.text = "Health %d" % [hero.health]
	$SpeedLabel.text = "Speed %d" % [hero.speed]
	$AttackLabel.text = "Attack %d" % [hero.attack]
	$PowersLabel.text = "Powers: %s" % "Flight" if hero.can_fly else ""
	$ProgressBar.value = hero.xp
	$LevelLabel.text = "Level %d" % hero.xp_threshold
