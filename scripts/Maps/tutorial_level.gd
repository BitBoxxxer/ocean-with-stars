extends Control

@onready var text_edit: TextEdit = $Center_screen/MarginContainer/VBoxContainer/TextEdit
@onready var button: Button = $Center_screen/MarginContainer/VBoxContainer/Button

#@export var quest : Quest

func _ready():
	button.visible = false

func _process(_delta):
	if text_edit.text != "":
		button.visible = true
	else:
		button.visible = false
	

func _on_button_pressed() -> void:
	TransScreen.transition()
	await TransScreen.on_transition_finish
	get_tree().change_scene_to_file("res://scenes/Maps/tutorial.tscn")
	#if quest.quest_status == quest.QuestStatus.available:
		#quest.start_quest()
