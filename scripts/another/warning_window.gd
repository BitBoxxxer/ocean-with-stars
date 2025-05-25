extends Window

@export var window_Title: String
@export var window_Text: String
@export var butt_text_First = "OK"
@export var butt_text_First_path_SceneName = "Path"
@export var butt_text_Second = "Отменить"

@onready var cancel_butt: Button = $HBoxContainer/CancelButt
@onready var ok_butt: Button = $HBoxContainer/OKButt
@onready var warning_text: RichTextLabel = $WarningText
@onready var window: Window = $"."


func _ready() -> void:
	window.title = window_Title
	warning_text.text = window_Text
	ok_butt.text = butt_text_First
	cancel_butt.text = butt_text_Second

func _on_close_requested() -> void:
	window.hide()

func _on_ok_butt_pressed() -> void:
	Specifications.new_game_load.emit()
	print('Работает кнопка OK!!!')
	if Specifications.new_game_load:
		print('Сигнал сработал !')

func _on_cancel_butt_pressed() -> void:
	print('Работает кнопка Cancel!!!')
	window.hide()
