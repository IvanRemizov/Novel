extends Control

@onready var dialog_panel = preload("res://dialog.tscn")
@onready var dialog_info = global.dialog_main_info
var main_dialog_num = []
var choise_dialog_num = []
var num_variant = 0
var num_dialog = 0

func _ready() -> void:
	for j in len(dialog_info):
		main_dialog_num.append(dialog_info[j].DialogNum.rsplit("_")[0])
	for i in len(dialog_info):
		var path = %GraphEdit
		if num_variant != 0:
			connect_node(i, num_variant+1)
			num_variant -= 1
			continue
		#Создание варианта
		elif i+1 < len(main_dialog_num) and main_dialog_num[i] == main_dialog_num[i+1] and num_variant <= i:
			var GraphFr = GraphFrame.new()
			GraphFr.name = main_dialog_num[i]
			GraphFr.title = main_dialog_num[i]
			%GraphEdit.add_child(GraphFr)
			for j in range(i, main_dialog_num.rfind(str(num_dialog))+1):
				var temp_dialog_panel = dialog_panel.instantiate()
				%GraphEdit.add_child(temp_dialog_panel.creat(dialog_info[j], j))
				%GraphEdit.attach_graph_element_to_frame(str(dialog_info[j].DialogNum),dialog_info[i].DialogNum.rsplit("_")[0])
			num_variant = main_dialog_num.rfind(str(num_dialog))-i
			num_dialog += 1
		#Создание без варианта
		elif i+num_variant < i+1:
			var GraphFr = GraphFrame.new()
			GraphFr.name = main_dialog_num[i]
			GraphFr.title = main_dialog_num[i]
			%GraphEdit.add_child(GraphFr)
			var temp_dialog_panel = dialog_panel.instantiate()
			%GraphEdit.add_child(temp_dialog_panel.creat(dialog_info[i], i))
			%GraphEdit.attach_graph_element_to_frame(str(dialog_info[i].DialogNum),dialog_info[i].DialogNum.rsplit("_")[0])
			num_variant = 0
			num_dialog += 1
		connect_node(i, num_variant+1)
		%GraphEdit.arrange_nodes()
func connect_node(num, count):
	if num+1 >= len(main_dialog_num):
		return
	elif count == 1:
		%GraphEdit.connect_node(str(main_dialog_num[num]) +"_"+ str(0), 0, str(main_dialog_num[num+1]) +"_" + str(0), 0)
	else:
		for i in count:
			%GraphEdit.connect_node(str(main_dialog_num[num]) +"_"+ str(i), 0, str(int(main_dialog_num[num])+1) +"_0", 0)
			%GraphEdit.connect_node(str(int(main_dialog_num[num])-1) +"_0", 0, str(main_dialog_num[num]) + "_" + str(i), 0)
