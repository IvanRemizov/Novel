extends Node2D

@export var RichText = RichTextLabel

func _ready() -> void:
	pass 

func _on_button_pressed() -> void:
	RichText.text = "1"
