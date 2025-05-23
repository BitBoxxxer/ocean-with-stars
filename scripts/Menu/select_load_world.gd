extends Node2D


func _on_load_butt_1_pressed() -> void:
	TransScreen.transition()
	await TransScreen.on_transition_finish
	SaveLoadManager.load_file(1)
	get_tree().change_scene_to_file("res://scenes/Maps/lobby.tscn")

func _on_load_butt_2_pressed() -> void:
	TransScreen.transition()
	await TransScreen.on_transition_finish
	SaveLoadManager.load_file(2)
	get_tree().change_scene_to_file("res://scenes/Maps/lobby.tscn")

func _on_load_butt_3_pressed() -> void:
	TransScreen.transition()
	await TransScreen.on_transition_finish
	SaveLoadManager.load_file(3)
	get_tree().change_scene_to_file("res://scenes/Maps/lobby.tscn")


func _on_button_pressed() -> void:
	TransScreen.transition()
	await TransScreen.on_transition_finish
	get_tree().change_scene_to_file("res://scenes/Menu/menu_lobby.tscn")
