extends Node

@onready var health = $Indicators/Panel/VBoxContainer/health
@onready var money = $Indicators/Panel/VBoxContainer/money
@onready var exp = $Indicators/Panel/VBoxContainer/exp

func _process(_delta):
	health.text = "жизней: " +str(Specifications.health_count)
	money.text = "денег: " +str(Specifications.money_count)
	exp.text = "опыта: " +str(Specifications.exp_count)
	
	if Input.is_action_just_pressed("Menu"):
		TransScreen.transition()
		await TransScreen.on_transition_finish
		get_tree().change_scene_to_file("res://scenes/Player/WindowsInGame/window_in_game_menu.tscn")

func save():
	var save_dict = {
		"health" : Specifications.health_count,
		"money" : Specifications.money_count,
		"exp" : Specifications.exp_count,
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
		file.close()
