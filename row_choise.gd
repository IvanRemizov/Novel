extends Button

@export var button : Button

func create_row(num):
	var choise_dict = global.dialog_main_info[0].choise
	var choise = choise_dict[choise_dict.keys()[num]]
	button.name = str(num)
	button.text = choise.text_choise
	return self


func _on_pressed() -> void:
	get_node("/root/main").complete_choise(int(str(button.name)))
