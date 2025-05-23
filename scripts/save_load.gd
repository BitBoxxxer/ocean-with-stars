extends Node

var f_save_path = "user://1_OWSgame.save"
var s_save_path = "user://2_OWSgame.save"
var t_save_path = "user://3_OWSgame.save"

func save():
	var save_data = {
		"player_h" : Specifications.health_count,
		"player_m" : Specifications.money_count,
		"player_e" : Specifications.exp_count,
	}
	return save_data

func save_file():
	var save_game = FileAccess.open(f_save_path, FileAccess.WRITE)
	var json_string = JSON.stringify(save())
	save_game.store_line(json_string)

func load_file():
	if not FileAccess.file_exists(f_save_path):
		return
	var save_game = FileAccess.open(f_save_path, FileAccess.READ)
	
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
		
