extends GraphNode

@export var requirements = Label
@export var get_points = Label

func creat(dialog_info, num):
	self.name = dialog_info.DialogNum
	self.set_slot(0, false, 10, Color.BLACK ,true, 10, Color.BLACK)
	self.set_slot(1, true, 10, Color.BLACK ,false, 10, Color.BLACK)
	get_titlebar_hbox().get_child(0).text = dialog_info.DialogTitle
	requirements.text = "           D, I, L, N, S \n"
	requirements.text += "Надо"+ str(dialog_info.Requirements.values())
	get_points.text = "Дает" + str(dialog_info.choise[dialog_info.choise.keys()[0]].point.values())
	return self
