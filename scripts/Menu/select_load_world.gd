extends Node2D

@onready var window_Title = "Window title"
@onready var window_Text = "Hello"
@onready var butt_text_First = "OK"
@onready var butt_text_First_path_SceneName = "Path"
@onready var butt_text_Second = "Отменить"
@onready var window: Window = $Window

func _ready() -> void:
	window.visible = false


func _on_load_butt_1_pressed() -> void:
	if not FileAccess.file_exists("user://1_OWSgame.save"):
		print('работает сигнал окна ошибки')
		window.visible = true
		
		await Specifications.new_game_load
		print('Создается новая игра!')
		
		TransScreen.transition()
		await TransScreen.on_transition_finish
		
		SaveLoadManager.load_file(1)
		get_tree().change_scene_to_file("res://scenes/Maps/lobby.tscn")
	else:
		print('Запускается сохраненный прогресс')
		TransScreen.transition()
		await TransScreen.on_transition_finish
		SaveLoadManager.load_file(1)
		get_tree().change_scene_to_file("res://scenes/Maps/lobby.tscn")
	

func _on_load_butt_2_pressed() -> void:
	if not FileAccess.file_exists("user://2_OWSgame.save"):
		print('работает сигнал окна ошибки')
		window.visible = true
		
		await Specifications.new_game_load
		print('Создается новая игра!')
		
		TransScreen.transition()
		await TransScreen.on_transition_finish
		
		SaveLoadManager.load_file(2)
		get_tree().change_scene_to_file("res://scenes/Maps/lobby.tscn")
	else:
		print('Запускается сохраненный прогресс')
		TransScreen.transition()
		await TransScreen.on_transition_finish
		SaveLoadManager.load_file(2)
		get_tree().change_scene_to_file("res://scenes/Maps/lobby.tscn")

func _on_load_butt_3_pressed() -> void:
	if not FileAccess.file_exists("user://3_OWSgame.save"):
		print('работает сигнал окна ошибки')
		window.visible = true
		
		await Specifications.new_game_load
		print('Создается новая игра!')
		
		TransScreen.transition()
		await TransScreen.on_transition_finish
		
		SaveLoadManager.load_file(3)
		get_tree().change_scene_to_file("res://scenes/Maps/lobby.tscn")
	else:
		print('Запускается сохраненный прогресс')
		TransScreen.transition()
		await TransScreen.on_transition_finish
		SaveLoadManager.load_file(3)
		get_tree().change_scene_to_file("res://scenes/Maps/lobby.tscn")

func _on_button_pressed() -> void:
	TransScreen.transition()
	await TransScreen.on_transition_finish
	get_tree().change_scene_to_file("res://scenes/Menu/menu_lobby.tscn")
