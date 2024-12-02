extends Node
var dialog_main_info = loadresurse("res://Main/Data/")
var save = loadresurse("res://Main/Save")
	
func loadresurse(path):
	var dir = DirAccess.open(path)
	var file_name = dir.get_files()
	var res : Array[Resource]
	res.resize(len(file_name))
	var dir_name = dir.get_current_dir()
	for i in len(file_name):
		res[i] = ResourceLoader.load(dir_name + "/" + file_name[i])
	return res

func savefile(savefile):
	ResourceSaver.save(savefile, "res://Main/Save/"+ "autosave" +".tres")
	print("Файл сохранен!")
	print(savefile)
