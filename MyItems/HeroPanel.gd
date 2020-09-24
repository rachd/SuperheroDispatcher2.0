extends Control

func show_hero(heroId):
	var hero_info = constants.get_hero_stats()[heroId]
	$Label.text = hero_info.name
