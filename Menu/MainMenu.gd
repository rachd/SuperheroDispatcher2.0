extends Control

func _input(event):
	if Input.is_action_pressed("menu"):
		if $PopupDialog.visible:
			$PopupDialog.visible = false
		else:
			$PopupDialog.popup_centered_ratio()

func _on_ResumeButton_pressed():
	$PopupDialog.visible = false


func _on_QuitButton_pressed():
	get_tree().quit()
