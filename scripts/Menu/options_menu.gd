extends Control

# Добавь @onready ссылки на твои UI элементы
@onready var master_mute_check_button: CheckButton = $Right/MarginContainer/VBoxContainer/CheckButton
@onready var master_volume_slider: HSlider = $Center/MarginContainerVolume/music/VBoxContainer/master
@onready var music_volume_slider: HSlider = $Center/MarginContainerVolume/music/VBoxContainer/music
@onready var sound_fx_volume_slider: HSlider = $Center/MarginContainerVolume/music/VBoxContainer/sound_FX

@onready var fullscreen_check_button: CheckButton = $Center/MarginContainerVolume/screen/VBoxContainer2/FullScreen
@onready var borderless_check_button: CheckButton = $Center/MarginContainerVolume/screen/VBoxContainer2/BorderLess
@onready var vsync_check_button: CheckButton = $Center/MarginContainerVolume/screen/VBoxContainer2/VSync


func _ready() -> void:
	# Аудио
	master_mute_check_button.button_pressed = SettingsManager.is_master_muted
	master_volume_slider.value = SettingsManager.get_master_volume_linear()
	music_volume_slider.value = SettingsManager.get_music_volume_linear()
	sound_fx_volume_slider.value = SettingsManager.get_sfx_volume_linear()

	# Дисплей
	fullscreen_check_button.button_pressed = SettingsManager.is_fullscreen
	borderless_check_button.button_pressed = SettingsManager.is_borderless
	vsync_check_button.button_pressed = SettingsManager.is_vsync_enabled

	master_mute_check_button.toggled.connect(SettingsManager.set_master_mute)
	master_volume_slider.value_changed.connect(SettingsManager.set_master_volume)
	music_volume_slider.value_changed.connect(SettingsManager.set_music_volume)
	sound_fx_volume_slider.value_changed.connect(SettingsManager.set_sfx_volume)

	fullscreen_check_button.toggled.connect(SettingsManager.set_fullscreen)
	borderless_check_button.toggled.connect(SettingsManager.set_borderless)
	vsync_check_button.toggled.connect(SettingsManager.set_vsync)

func _on_back_butt_pressed():
	SettingsManager.save_settings()
	TransScreen.transition()
	await TransScreen.on_transition_finish
	get_tree().change_scene_to_file("res://scenes/Menu/menu_lobby.tscn")
