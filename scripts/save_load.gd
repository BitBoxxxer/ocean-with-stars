extends Node

var base_path = ""
var f_save_path = "user://1_OWSgame.save"
var s_save_path = "user://2_OWSgame.save"
var t_save_path = "user://3_OWSgame.save"

func save(num):
	match num:
		1:
			var save_data = {
				"player_h" : Specifications.health_count,
				"player_m" : Specifications.money_count,
				"player_e" : Specifications.exp_count,
			}
			return save_data
		0:
			var save_data = {
				"player_h" : 20,
				"player_m" : 0,
				"player_e" : 0,
			}
			return save_data

func save_file():
	match Specifications.world_load_file_ID:
		1:
			base_path = f_save_path
		2:
			base_path = s_save_path
		3:
			base_path = t_save_path
		_:
			print('Ошибка числа. Проверка saveManager -> save_file()')
	
	var save_game = FileAccess.open(base_path, FileAccess.WRITE)
	var json_string = JSON.stringify(save(1))
	save_game.store_line(json_string)

func load_file(num):
	match num:
		1:
			base_path = f_save_path
			Specifications.world_load_file_ID = 1
		2:
			base_path = s_save_path
			Specifications.world_load_file_ID = 2
		3:
			base_path = t_save_path
			Specifications.world_load_file_ID = 3
	
	if not FileAccess.file_exists(base_path): # если выбранная ячейка не содержит файла
		Specifications.warning_window_type = 0
		var save_game = FileAccess.open(base_path, FileAccess.WRITE)
		var json_string = JSON.stringify(save(0))
		save_game.store_line(json_string)
	
	var save_game = FileAccess.open(base_path, FileAccess.READ)
	
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		var node_data = json.get_data()
		print(node_data)
		var data = json.get_data()
		if data.has("player_h"):
			Specifications.health_count = data["player_h"]
		if data.has("player_m"):
			Specifications.money_count = data["player_m"]
		if data.has("player_e"):
			Specifications.exp_count = data["player_e"]
