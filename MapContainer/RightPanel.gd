extends VBoxContainer

func display_hero(id):
	var hero = constants.get_hero_stats()[id]
	$NameLabel.text = hero.name
	$HealthLabel.text = "Health %d" % [hero.health]
	$SpeedLabel.text = "Speed %d" % [hero.speed]
	$AttackLabel.text = "Attack %d" % [hero.attack]
