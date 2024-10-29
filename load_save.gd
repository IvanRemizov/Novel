extends Node
var text : Array[Resource]
@onready var num_dialog

func _ready() -> void:
	text = loadresurse("res://Main/Data/")
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
	var save = loadresurse("res://Main/Save")
	if len(save) == 0:
		num_dialog = 0
	else:
		num_dialog = save[0].num_dialog

func savefile(name_button, num_dialog_save):
	var savefile = SaveFile.new()
	loadfile()
	savefile.num_dialog = num_dialog_save
	ResourceSaver.save(savefile, "res://Main/Save/"+ name_button +".tres")
