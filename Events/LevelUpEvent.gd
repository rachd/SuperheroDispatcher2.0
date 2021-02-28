extends "res://Events/Event.gd"

func _description_set(new_value):
	description = new_value

func _description_get():
	return "%s has reached level %d" % [entity.title, entity.xp_threshold]
