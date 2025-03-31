extends CanvasLayer

signal transitioned

func transition():
	$AnimationPlayer.play("to_black")
	print("переход в жопу негра")

func _on_animation_player_animation_finished(anim_name):
	if (anim_name == "to_black"):
		print("использование сигнала перехода [to_black]")
		emit_signal("transitioned")
		$AnimationPlayer.play("to_norm")
	if (anim_name == "to_norm"):
		print("завершение перехода [to_norm]")
