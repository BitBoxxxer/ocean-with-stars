extends Control

func _on_am_back_butt_pressed():
	TransScreen.transition()
	await TransScreen.on_transition_finish
	get_tree().change_scene_to_file("res://scenes/Menu/menu_lobby.tscn")
