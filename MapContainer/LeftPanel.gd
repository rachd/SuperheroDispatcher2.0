extends VBoxContainer

func display_villain(id):
	var villain = constants.get_villain_stats()[id]
	$Label.text = villain.name
