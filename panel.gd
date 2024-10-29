extends Panel

func _on_button_pressed() -> void:
	global.savefile($".".name, 0)
