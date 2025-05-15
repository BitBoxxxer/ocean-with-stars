extends Node

func _on_button_pressed() -> void:
	TransScreen.transition()
	await TransScreen.on_transition_finish
	get_tree().change_scene_to_file("res://scenes/Maps/lobby.tscn")
