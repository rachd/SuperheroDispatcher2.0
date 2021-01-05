extends VBoxContainer

func display_hero(id):
	var hero = constants.get_hero_stats()[id]
	$Label.text = hero.name
