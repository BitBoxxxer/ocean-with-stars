extends Node

const SETTINGS_FILE_PATH = "user://game_settings.cfg" # Путь к файлу настроек

var master_volume_db: float = 0.0 # Громкость мастер-шины в дБ
var music_volume_db: float = 0.0  # Громкость музыкальной шины в дБ
var sfx_volume_db: float = 0.0    # Громкость шины звуковых эффектов в дБ
var is_master_muted: bool = false # Состояние заглушения мастер-шины

var is_fullscreen: bool = false # Состояние полноэкранного режима
var is_borderless: bool = false # Состояние полноэкранного режима без рамки
var is_vsync_enabled: bool = false # Состояние V-Sync

func _ready() -> void:
	load_settings()

func load_settings() -> void:
	var config = ConfigFile.new()
	var err = config.load(SETTINGS_FILE_PATH)

	if err != OK:
		apply_audio_settings()
		apply_display_settings()
		save_settings() # дефолтные настройки
		return

	# Загружаем настройки из файла
	master_volume_db = config.get_value("Audio", "master_volume_db", 0.0)
	music_volume_db = config.get_value("Audio", "music_volume_db", 0.0)
	sfx_volume_db = config.get_value("Audio", "sfx_volume_db", 0.0)
	is_master_muted = config.get_value("Audio", "master_muted", false)

	is_fullscreen = config.get_value("Display", "fullscreen", false)
	is_borderless = config.get_value("Display", "borderless", false)
	is_vsync_enabled = config.get_value("Display", "vsync_enabled", false)

	apply_audio_settings()
	apply_display_settings()
	print("Настройки загружены и применены.")

func save_settings() -> void:
	var config = ConfigFile.new()

	config.set_value("Audio", "master_volume_db", master_volume_db)
	config.set_value("Audio", "music_volume_db", music_volume_db)
	config.set_value("Audio", "sfx_volume_db", sfx_volume_db)
	config.set_value("Audio", "master_muted", is_master_muted)

	config.set_value("Display", "fullscreen", is_fullscreen)
	config.set_value("Display", "borderless", is_borderless)
	config.set_value("Display", "vsync_enabled", is_vsync_enabled)

	var err = config.save(SETTINGS_FILE_PATH)
	if err != OK:
		printerr("Ошибка сохранения настроек: ", err)
	else:
		print("Настройки сохранены.")

func apply_audio_settings() -> void:
	AudioServer.set_bus_volume_db(0, master_volume_db)
	AudioServer.set_bus_volume_db(1, music_volume_db)
	AudioServer.set_bus_volume_db(2, sfx_volume_db)
	AudioServer.set_bus_mute(3, is_master_muted)

func apply_display_settings() -> void:
	if is_borderless:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	elif is_fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

	if is_vsync_enabled:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

func set_master_volume(value: float) -> void:
	master_volume_db = linear_to_db(value)
	apply_audio_settings()
	save_settings()

func set_music_volume(value: float) -> void:
	music_volume_db = linear_to_db(value)
	apply_audio_settings()
	save_settings()

func set_sfx_volume(value: float) -> void:
	sfx_volume_db = linear_to_db(value)
	apply_audio_settings()
	save_settings()

func set_master_mute(toggled_on: bool) -> void:
	is_master_muted = toggled_on
	apply_audio_settings()
	save_settings()

func set_fullscreen(toggled_on: bool) -> void:
	is_fullscreen = toggled_on
	if toggled_on:
		is_borderless = false
	apply_display_settings()
	save_settings()

func set_borderless(toggled_on: bool) -> void:
	is_borderless = toggled_on
	if toggled_on:
		is_fullscreen = false
	apply_display_settings()
	save_settings()

func set_vsync(toggled_on: bool) -> void:
	is_vsync_enabled = toggled_on
	apply_display_settings()
	save_settings()

# Вспомогательные функции для получения значений ползунков (0-1)
func get_master_volume_linear() -> float:
	return db_to_linear(master_volume_db)

func get_music_volume_linear() -> float:
	return db_to_linear(music_volume_db)

func get_sfx_volume_linear() -> float:
	return db_to_linear(sfx_volume_db)
