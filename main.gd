extends Node2D

@export var RichText = RichTextLabel
@onready var now_dialog = global.num_dialog
@onready var sub_chapter_info = global.dialog_main_info[now_dialog]
@onready var save_info = global.save[now_dialog]
@onready var row_choise = preload("res://row_choise.tscn")
var now_text = 0
const MAX_ROW_MAINTEXT = 5

func _ready() -> void:
	print_main_text()
	
func _on_button_pressed() -> void:
	var arr_text_enter = sub_chapter_info.Text.rsplit("$")
	if now_dialog == len(arr_text_enter)-2:
		return
	else:
		print_main_text()

func _on_save_button_pressed() -> void:
	global.savefile("base_save", now_dialog)

func print_main_text():
	RichText.text = ""
	var arr_text_enter = sub_chapter_info.Text.rsplit("#")
	for i in range(now_text,len(arr_text_enter)):
		if "$" in arr_text_enter[i] or i == MAX_ROW_MAINTEXT+1:
			RichText.text += arr_text_enter[i].rstrip("$")
			now_text = i+1
			return
		else:
			RichText.text += arr_text_enter[i] + "\n"
	now_dialog += 1
	print_choise()
	check_requirements()

func print_choise():	
	for i in sub_chapter_info.choise.size():
		var temp_row_choise = row_choise.instantiate()
		%VBoxChoise.add_child(temp_row_choise.create_row(i))

func complete_choise(num):
	global.num_dialog += 1
	for i in len(%VBoxChoise.get_children()):
		%VBoxChoise.get_child(i).queue_free()
	print(num)

func check_requirements():
	for i in sub_chapter_info.Requirements.size():
		if sub_chapter_info.Requirements.values()[i] <= save_info.points.values()[i] and sub_chapter_info.Requirements.values()[i] != 0:
			now_dialog += 1
			return
