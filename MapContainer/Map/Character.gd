extends KinematicBody2D

var title = ""
var speed = 0
var attack = 0
var health = 0

var current_speed = 0
var target_position: Vector2
var target = null
var current_health = health
var target_type = null

var spawn_area = Rect2(0, 0, 300, 300)
var cell_size = constants.get_cell_size()
var path
var rng = RandomNumberGenerator.new()


signal find_path(start, end, target)

# public methods
func stop_attack():
	$AttackTimer.stop()
	target = null
	
func set_stats(stats):
	title = stats.title
	speed = stats.speed
	attack = stats.attack
	health = stats.health
	current_health = health
	$Label.text = str(current_health)
			
func pause(isPaused):
	$AttackTimer.set_paused(isPaused)
	if isPaused:
		current_speed = 0
	else:
		current_speed = speed
		
func reset():
	_on_move()
	current_health = health
	$Label.text = str(current_health)
	_set_initial_position()
		
func take_damage(damage):
	current_health -= damage
	$Label.text = str(current_health)
	if (current_health <= 0):
		_die()
		
func move_to_point(target_position):
	_on_move()
	var relative_position = target_position - position
	if relative_position.length() <= 8:
		target_position = position
	else:
		emit_signal("find_path", position, target_position, self)
		
func heal(amount):
	current_health += amount
	if current_health > health:
		current_health = health
	$Label.text = str(current_health)
	
func start_attack(_target):
	target = _target
	$AttackTimer.start()
		
# private methods
func _on_move():
	$AttackTimer.stop()
	if target:
		target.stop_attack()
	stop_attack()
	
func _set_initial_position():
	position.x = spawn_area.position.x + rng.randi_range(0, spawn_area.size.x / cell_size) * cell_size
	position.y = spawn_area.position.y + rng.randi_range(0, spawn_area.size.y / cell_size) * cell_size
	target_position = position
	path = []
	
func _ready():
	rng.randomize()
	_set_initial_position()
	$Label.text = str(current_health)
	current_speed = speed
	self.connect("find_path", get_node("/root/MapContainer/Map"), "_calculate_new_path")
	
func _on_AttackTimer_timeout():
	target.take_damage(attack)

func _die():
	target.stop_attack()
	$AttackTimer.stop()
	self.queue_free()
	
func _handle_overlap(overlap):
	pass
		
func _process(delta):
	if path:
		var target_position = path[0]
		var direction = (target_position - position).normalized()
		position += direction * current_speed * delta
		var current = position
		var dist = position.distance_to(target_position)
		if position.distance_to(target_position) < 1:
			path.remove(0)
			if path.size() == 0:
				position = target_position
				path = null
				var overlaps = $Area2D.get_overlapping_areas()
				for overlap in overlaps: 
					_handle_overlap(overlap)
