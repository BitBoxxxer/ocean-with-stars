extends Control

@export
var bus_name : String

var bus_index: int

func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	#volume_butt_value_changed.connect(_on_value_changed)

func _on_check_button_toggled(toggled_on):
	AudioServer.set_bus_mute(0, toggled_on)

func _on_back_butt_pressed():
	TransScreen.transition()
	await TransScreen.on_transition_finish
	get_tree().change_scene_to_file("res://scenes/Menu/menu_lobby.tscn")

func _on_volume_butt_value_changed(value):
	AudioServer.set_bus_volume_db(
		0,
		linear_to_db(value)
	)
	#volume(0, value/10)
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
	#volume(2, value/10)
func volume(bus_index, value):
	AudioServer.set_bus_volume_db(bus_index, value)


# ДЛЯ PC OCS. ВЫРЕЗАТЬ ДЛЯ МОБИЛЬНОЙ ВЕРСИИ!!!!:
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
