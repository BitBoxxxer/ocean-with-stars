extends Node

var f_save_path = "user://1_OWSgame.save"
var s_save_path = "user://2_OWSgame.save"
var t_save_path = "user://3_OWSgame.save"

var save_data = {
	"player_h" : Specifications.health_count,
	"player_m" : Specifications.money_count,
	"player_e" : Specifications.exp_count,
}

func save_file():
	var file = FileAccess.open(f_save_path, FileAccess.WRITE)
	file.store_var(save_data)
	print(save_data)

func load_file():
	if not FileAccess.file_exists(f_save_path):
		return
	var file = FileAccess.open(f_save_path, FileAccess.READ)
	save_data = file.get_var()
	print(save_data)
