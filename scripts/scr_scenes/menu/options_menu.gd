extends Control

func _on_check_button_toggled(toggled_on):
	AudioServer.set_bus_mute(0, toggled_on)

func _on_back_butt_pressed():
	get_tree().change_scene_to_file("res://scenes/sce_menu/menu.tscn")


func _on_volume_butt_value_changed(value):
	volume(0, value)
func _on_music_value_changed(value: float) -> void:
	volume(1, value)
func _on_sound_fx_value_changed(value: float) -> void:
	volume(2, value)
func volume(bus_index, value):
	AudioServer.set_bus_volume_db(bus_index, value)


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


# чисто звуки:
func _on_full_screen_pressed():
	pass # Replace with function body.
