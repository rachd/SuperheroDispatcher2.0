extends KinematicBody2D

var rng = RandomNumberGenerator.new()
var spawn_area = Rect2(0, 0, 300, 300)
var cell_size = constants.get_cell_size()

func _set_initial_position():
	position.x = spawn_area.position.x + rng.randi_range(0, spawn_area.size.x / cell_size) * cell_size
	position.y = spawn_area.position.y + rng.randi_range(0, spawn_area.size.y / cell_size) * cell_size
	
func _ready():
	rng.randomize()
	_set_initial_position()
