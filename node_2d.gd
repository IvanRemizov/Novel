extends Node2D

@export var RichText = RichTextLabel
@onready var now_dialog = global.num_dialog

func _ready() -> void:
	RichText.text = global.text[now_dialog].Text
	
func _on_button_pressed() -> void:
	if now_dialog >= len(global.text)-1:
		return
	else:
		now_dialog += 1
		RichText.text = global.text[now_dialog].Text

func _on_save_button_pressed() -> void:
	global.savefile("base_save", now_dialog)
