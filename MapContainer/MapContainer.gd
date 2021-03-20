extends VBoxContainer

var time = 900
var level_up_event_scene = preload("res://Events/LevelUpEvent.tscn")

func _display_event_entity(entity):
	pass
	#$HBoxContainer2/LeftPanel.display_event_entity(entity)

func _ready():
	_display_budget()
	$CanvasLayer/PanelContainer/HBoxContainer/DayLabel.text = "Day " + str(gameVariables.day)
	$CanvasLayer/PanelContainer/HBoxContainer/TimeLabel.text = _formatTime()
	
func _display_budget():
	$CanvasLayer/PanelContainer/HBoxContainer/Budgetlabel.text = _formatMoney(gameVariables.budget)

func _formatTime():
	# convert to 12-hour time with am/pm
	var hours = time / 100
	var hoursString = str(12 if hours % 12 == 0 else hours % 12)
	var minutes = time % 100
	var amPm = "AM"
	if hours >= 12:
		amPm = "PM"
	return "%s:%02d %s" % [hoursString, minutes, amPm]
	
func _formatMoney(amount):
	var money = ""
	var temp_money = str(amount)
	var money_length = len(temp_money)
	while money_length > 3:
		money = "," + temp_money.substr(money_length - 3, 3) + money
		money_length -= 3
	return "$" + temp_money.substr(0, money_length) + money

func _on_ClockIncrement_timeout():
	if time % 100 == 50:
		time -= 50
		time += 100
	else:
		time += 1
	
	if time == 1700:
		emit_signal("end_of_day")
	else:
		$CanvasLayer/PanelContainer/HBoxContainer/TimeLabel.text = _formatTime()
	
func _on_Villain_info(villain):
	$CanvasLayer3/LeftPanelContainer/LeftPanel.display_villain(villain.id)
	$CanvasLayer3/LeftPanelContainer.visible = true
	
func _on_Villain_do_damage(attack, cell_type):
	var damage = constants.get_tile_worth_by_id(cell_type) * attack
	gameVariables.budget -= damage
	gameVariables.update_property_damage(damage)
	_display_budget()
	
func _on_Hero_level_up(hero):
	var level_up_event = level_up_event_scene.instance()
	level_up_event.entity = hero
	$CanvasLayer2/PanelContainer/EventContainer.add_event(level_up_event)
	
func _on_Hero_clicked(hero):
	$CanvasLayer4/RightPanelContainer/RightPanel._on_Hero_clicked(hero)
	$Map._on_Hero_clicked(hero)
	
func _on_Map_clicked():
	$CanvasLayer4/RightPanelContainer/RightPanel._on_Map_clicked()
