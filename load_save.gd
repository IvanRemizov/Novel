extends Node
var dialog_main_info = loadresurse("res://Main/Data/")
var save = loadresurse("res://Main/Save")
@onready var num_dialog

func _ready() -> void:
	loadfile()
	
func loadresurse(path):
	var dir = DirAccess.open(path)
	var file_name = dir.get_files()
	var res : Array[Resource]
	res.resize(len(file_name))
	var dir_name = dir.get_current_dir()
	for i in len(file_name):
		res[i] = ResourceLoader.load(dir_name + "/" + file_name[i])
	return res
	
func loadfile():
	if len(save) == 0:
		num_dialog = 0
	else:
		num_dialog = save[0].num_dialog

func savefile(name_button, num_dialog_save):
	var savefile = SaveFile.new()
	loadfile()
	savefile.num_dialog = num_dialog_save
	ResourceSaver.save(savefile, "res://Main/Save/"+ name_button +".tres")
