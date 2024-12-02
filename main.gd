extends Node2D

@export var RichText = RichTextLabel
@onready var num_phrase = global.save[0].num_phrase
@onready var num_chapter = global.save[0].num_chapter
@onready var chapter_data = global.dialog_main_info[num_chapter]
@onready var save_data = global.save[0]
@onready var row_choise = preload("res://row_choise.tscn")
var start_num_phrase = 0

const MAX_ROW_MAINTEXT = 5

func _ready() -> void:
	print_main_text()
	
func _on_button_pressed() -> void:
	var arr_text_enter = chapter_data.Text.rsplit("$")
	if num_phrase == len(arr_text_enter)-2:
		return
	else:
		print_main_text()

func _on_save_button_pressed() -> void:
	var savefile = SaveFile.new()
	savefile.num_phrase = start_num_phrase
	savefile.num_chapter = num_chapter
	global.savefile(savefile)

func print_main_text():
	RichText.text = ""
	start_num_phrase = num_phrase
	var arr_text_enter = chapter_data.Text.rsplit("#")
	for i in range(num_phrase,len(arr_text_enter)):
		if "$" in arr_text_enter[i] or i == MAX_ROW_MAINTEXT+1:
			RichText.text += arr_text_enter[i].rstrip("$")
			num_phrase = i+1
			return
		else:
			RichText.text += arr_text_enter[i] + "\n"
	print_choise()
	check_requirements()

func print_choise():	
	for i in chapter_data.choise.size():
		var temp_row_choise = row_choise.instantiate()
		%VBoxChoise.add_child(temp_row_choise.create_row(i))

func complete_choise(num):
	global.save[0].num_chapter += 1
	num_chapter += 1
	num_phrase = 0
	start_num_phrase = 0
	var num_variant = num_chapter
	while global.dialog_main_info[num_variant].DialogNum.split("_")[0] == global.dialog_main_info[num_variant+1].DialogNum.split("_")[0]:
		print(global.dialog_main_info[num_variant].DialogNum.split("_")[0])
		num_variant +=1
		#написать взаимодействие с вариантами chapter
	chapter_data = global.dialog_main_info[num_chapter]
	for i in len(%VBoxChoise.get_children()):
		%VBoxChoise.get_child(i).queue_free()
	print_main_text()


func check_requirements():
	for i in chapter_data.Requirements.size():
		if chapter_data.Requirements.values()[i] <= save_data.points.values()[i] and chapter_data.Requirements.values()[i] != 0:
			return
