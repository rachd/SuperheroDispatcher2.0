extends VBoxContainer

var time = 900

func _display_event_entity(entity):
	$HBoxContainer2/LeftPanel.display_event_entity(entity)

func _ready():
	$HBoxContainer/Budgetlabel.text = "$" + str(gameVariables.budget)
	$HBoxContainer/DayLabel.text = "Day " + str(gameVariables.day)
	$HBoxContainer/TimeLabel.text = _formatTime()

func _formatTime():
	# convert to 12-hour time with am/pm
	var hours = time / 100
	var hoursString = str(12 if hours % 12 == 0 else hours % 12)
	var minutes = time % 100
	var minutesString = str(minutes)
	if minutes == 0:
		minutesString = "00"
	var amPm = "AM"
	if hours >= 12:
		amPm = "PM"
	return hoursString + ":" + minutesString + " " + amPm

func _on_ClockIncrement_timeout():
	if time % 100 == 50:
		time -= 50
		time += 100
	else:
		time += 10
	
	if time == 1700:
		emit_signal("end_of_day")
	else:
		$HBoxContainer/TimeLabel.text = _formatTime()
		
func _on_Hero_clicked(hero):
	$HBoxContainer2/RightPanel.display_hero(hero.id)
	$HBoxContainer2/Map._on_Hero_clicked(hero)
	
