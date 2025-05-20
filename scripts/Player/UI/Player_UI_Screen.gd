extends Node

@onready var health = $Indicators/Panel/VBoxContainer/health
@onready var money = $Indicators/Panel/VBoxContainer/money
@onready var exp = $Indicators/Panel/VBoxContainer/exp
@onready var save_manager = preload("res://scripts/Player/save_Load.gd").new()

var health_count = 20
var money_count = 0
var exp_count = 0

func _process(_delta):
	health.text = "health: " +str(health_count)
	money.text = "money: " +str(money_count)
	exp.text = "exp: " +str(exp_count)

func _on_button_pressed() -> void:
	save_manager.save_game()


func save():
	var save_dict = {
		"health" : health_count,
		"money" : money_count,
		"exp" : exp_count,
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
