extends Control # просто для настройки кнопок...


func _on_play_game_pressed() -> void:
	Specifications.health_count += Specifications.max_health_count * 0.5
	TransScreen.transition()
	await TransScreen.on_transition_finish
	get_tree().change_scene_to_file("res://scenes/Maps/lobby.tscn")


func _on_exit_menu_pressed() -> void:
	TransScreen.transition()
	await TransScreen.on_transition_finish
	get_tree().change_scene_to_file("res://scenes/another/load.tscn")
