extends VBoxContainer

var item_row_scene = preload("res://MyItems/ItemRow.tscn")

func _ready():
	for owned_item_id in gameVariables.owned_item_ids:
		var item_row = item_row_scene.instance()
		item_row.assign_item(owned_item_id)
		$ScrollContainer/ItemRowContainer.add_child(item_row)
