extends Window

@onready var window: Window = $"."
@export var window_title = window.title

func _on_close_requested() -> void:
	window.hide()
