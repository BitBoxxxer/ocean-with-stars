extends Control

func _process(_delta):
	if Input.is_action_just_pressed("Inventare"):
		TransScreen.transition()
		await TransScreen.on_transition_finish
		get_tree().change_scene_to_file("res://scenes/Maps/lobby.tscn")

func _on_back_butt_pressed() -> void:
	TransScreen.transition()
	await TransScreen.on_transition_finish
	get_tree().change_scene_to_file("res://scenes/Maps/lobby.tscn")


func _on_options_butt_pressed() -> void:
	TransScreen.transition()
	await TransScreen.on_transition_finish
	get_tree().change_scene_to_file("res://scenes/Player/WindowsInGame/window_in_game_options.tscn")


func _on_save_butt_pressed() -> void:
	pass # Replace with function body.


func _on_menu_butt_pressed() -> void:
	TransScreen.transition()
	await TransScreen.on_transition_finish
	get_tree().change_scene_to_file("res://scenes/Menu/menu_lobby.tscn")
