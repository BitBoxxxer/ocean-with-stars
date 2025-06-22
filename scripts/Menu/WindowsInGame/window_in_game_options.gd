extends Control

@onready var master_mute_check_button: CheckButton = $Settings/TopRightButts/VBoxContainer/CheckButton
@onready var master_volume_slider: HSlider = $Settings/SettingButts/music/VBoxContainer/master
@onready var music_volume_slider: HSlider = $Settings/SettingButts/music/VBoxContainer/music
@onready var sound_fx_volume_slider: HSlider = $Settings/SettingButts/music/VBoxContainer/sound_FX

@onready var fullscreen_check_button: CheckButton = $Settings/SettingButts/screen/VBoxContainer2/FullScreen
@onready var borderless_check_button: CheckButton = $Settings/SettingButts/screen/VBoxContainer2/BorderLess
@onready var vsync_check_button: CheckButton = $Settings/SettingButts/screen/VBoxContainer2/VSync


func _ready() -> void:
	# Инициализация UI элементов текущими значениями из SettingsManager
	# Аудио
	master_mute_check_button.button_pressed = SettingsManager.is_master_muted
	master_volume_slider.value = SettingsManager.get_master_volume_linear()
	music_volume_slider.value = SettingsManager.get_music_volume_linear()
	sound_fx_volume_slider.value = SettingsManager.get_sfx_volume_linear()

	# Дисплей
	fullscreen_check_button.button_pressed = SettingsManager.is_fullscreen
	borderless_check_button.button_pressed = SettingsManager.is_borderless
	vsync_check_button.button_pressed = SettingsManager.is_vsync_enabled

	# Подключение сигналов UI элементов к методам SettingsManager
	master_mute_check_button.toggled.connect(SettingsManager.set_master_mute)
	master_volume_slider.value_changed.connect(SettingsManager.set_master_volume)
	music_volume_slider.value_changed.connect(SettingsManager.set_music_volume)
	sound_fx_volume_slider.value_changed.connect(SettingsManager.set_sfx_volume)

	fullscreen_check_button.toggled.connect(SettingsManager.set_fullscreen)
	borderless_check_button.toggled.connect(SettingsManager.set_borderless)
	vsync_check_button.toggled.connect(SettingsManager.set_vsync)

func _on_back_butt_pressed():
	# Сохранение настроек и переход на другую сцену
	SettingsManager.save_settings()
	TransScreen.transition()
	await TransScreen.on_transition_finish
	get_tree().change_scene_to_file("res://scenes/Player/WindowsInGame/window_in_game_menu.tscn")
