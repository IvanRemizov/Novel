extends Panel

@export var save_name : Label
@export var chapter_name : Label
@export var save_time : Label
var save = global.save
var dialog_main_info = global.dialog_main_info

func _ready() -> void:
	load_autosave()
	pass

func load_row(num):
	if num == 0:
		load_autosave()
	else:
		pass
	
func load_autosave():
	chapter_name.text = dialog_main_info[save[0].num_chapter].DialogTitle
	save_time.text = Time.get_datetime_string_from_datetime_dict(Time.get_datetime_dict_from_system(), true)

func write_save():
	
	pass
	
