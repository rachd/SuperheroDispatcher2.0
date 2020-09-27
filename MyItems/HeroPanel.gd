extends HBoxContainer

func show_hero(heroId):
	var hero_info = constants.get_hero_stats()[heroId]
	$VBoxContainer/NameLabel.text = hero_info.name
	$VBoxContainer/GridContainer/HealthValue.text = str(hero_info.health)
	$VBoxContainer/GridContainer/SpeedValue.text = str(hero_info.speed)
	$VBoxContainer/GridContainer/AttackValue.text = str(hero_info.attack)
	display_items(heroId)
			
func display_items(heroId):
	var hero_items = {} 
	if gameVariables.assigned_items.has(heroId):
		hero_items = gameVariables.assigned_items[heroId]
	if hero_items.has("head"):
		var item_in_slot = constants.get_item_by_id(hero_items["head"])
		$GridContainer/HeadSlot.text = item_in_slot.title
	else:
		$GridContainer/HeadSlot.text = "No Head Item"
	if hero_items.has("leftHand"):
		var item_in_slot = constants.get_item_by_id(hero_items["leftHand"])
		$GridContainer/LeftHandSlot.text = item_in_slot.title
	else:
		$GridContainer/LeftHandSlot.text = "No Left Hand Item"
	if hero_items.has("rightHand"):
		var item_in_slot = constants.get_item_by_id(hero_items["rightHand"])
		$GridContainer/RightHandSlot.text = item_in_slot.title
	else:
		$GridContainer/RightHandSlot.text = "No Right Hand Item"
	if hero_items.has("body"):
		var item_in_slot = constants.get_item_by_id(hero_items["body"])
		$GridContainer/BodySlot.text = item_in_slot.title
	else:
		$GridContainer/BodySlot.text = "No Body Item"
	if hero_items.has("foot"):
		var item_in_slot = constants.get_item_by_id(hero_items["foot"])
		$GridContainer/FootSlot.text = item_in_slot.title
	else:
		$GridContainer/FootSlot.text = "No Foot Item"
