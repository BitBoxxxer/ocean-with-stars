extends Control

@export
var bus_name : String

var bus_index: int

func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	#volume_butt_value_changed.connect(_on_value_changed)

func _on_check_button_toggled(toggled_on):
	AudioServer.set_bus_mute(0, toggled_on)

func _on_full_screen_toggled(toggled_on):
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_border_less_toggled(toggled_on):
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_v_sync_toggled(toggled_on):
	if toggled_on == true:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

func _on_master_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		0,
		linear_to_db(value)
	)

func _on_music_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		1,
		linear_to_db(value)
	)
	#volume(1, value/10)
func _on_sound_fx_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		2,
		linear_to_db(value)
	)

func volume(bus_index, value):
	AudioServer.set_bus_volume_db(bus_index, value)

func _on_save_butt_pressed() -> void:
	pass # Объявление функции сохранения переменных игрока.

func _on_back_butt_pressed():
	TransScreen.transition()
	await TransScreen.on_transition_finish
	get_tree().change_scene_to_file("res://scenes/Player/WindowsInGame/window_in_game_menu.tscn")
