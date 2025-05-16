extends Control

#@export var quest : Quest

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Maps/tutorial.tscn")
	#if quest.quest_status == quest.QuestStatus.available:
		#quest.start_quest()
