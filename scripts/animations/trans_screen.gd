extends CanvasLayer

signal on_transition_finish

@onready var color_rect = $ColorRect
@onready var animation_player = $AnimationPlayer

func _ready():
	color_rect.visible = false

func _on_animation_player_animation_finished(anim_name):
	if (anim_name == "to_black"):
		on_transition_finish.emit()
		animation_player.play("to_norm")
	if (anim_name == "to_norm"):
		color_rect.visible = false

func transition():
	color_rect.visible = true
	animation_player.play("to_black")
