extends Node

@onready var player_ui_screen = null

signal signal_save
signal signal_load

func _ready():
	var ui_scene = preload("res://scenes/Player/Player_UI_Screen.tscn")
	player_ui_screen = ui_scene.instance()
	add_child(player_ui_screen)

func save():
	if player_ui_screen == null:
		print("Player UI Screen не инициализирован")
		return {}
	var save_dict = {
		"health" : player_ui_screen.health_count,
		"money" : player_ui_screen.money_count,
		"exp" : player_ui_screen.exp_count,
	}
	return save_dict

func save_game():
	var file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	if file:
		var json_string = JSON.stringify(save())
		file.store_line(json_string)
		file.close()
		print("save game!")

func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		print("Нет файла сохранения.")
		return
	var file = FileAccess.open("user://savegame.save", FileAccess.READ)
	if file:
		var json_string = file.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		if parse_result != OK:
			print("Ошибка парсинга JSON")
			return
		var data = json.get_data()
		print("load game!")
		if player_ui_screen:
			player_ui_screen.health_count = data.get("health", 20)
			player_ui_screen.money_count = data.get("money", 0)
			player_ui_screen.exp_count = data.get("exp", 0)
		file.close()
