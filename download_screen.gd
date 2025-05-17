extends Node

@onready var galactic: VideoStreamPlayer = $Animations/Load/Galactic
@onready var load: VideoStreamPlayer = $Animations/Load/Load
@onready var mobile_screen: VideoStreamPlayer = $Animations/Mobile/mobile_screen

@onready var animation_player: AnimationPlayer = $Animations/Mobile/RichTextLabel/AnimationPlayer
@onready var rich_text_label: RichTextLabel = $Animations/Mobile/RichTextLabel
@onready var dowload_text: RichTextLabel = $Animations/Load/Dowload_text

@onready var timer: Timer = $Animations/Load/Timer
@onready var timer_mob: Timer = $Animations/Mobile/Timer_mob

var mobile_warn_cont = false
var mob_timer_warn = false
var text = "Внимание! Эта игра содержит резкую и яркую пиксельную графику, а также насыщенные звуковые эффекты, которые могут вызывать неприятные ощущения или раздражение у чувствительных пользователей. Пожалуйста, играйте ответственно и делайте перерывы при необходимости."

func _ready():
	rich_text_label.text = text
	dowload_text.visible = false
	mobile_screen.play()
	animation_player.play("New_text")

func _on_mobile_screen_finished():
	if (mobile_warn_cont == true and mob_timer_warn == true):
		TransScreen.transition()
		await TransScreen.on_transition_finish
		rich_text_label.visible = false
		timer.start()
		galactic.play()
		dowload_text.visible = true
		load.play()
	else:
		mobile_screen.play()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "New_text":
		mobile_warn_cont = true
		timer_mob.start()

func _on_timer_timeout() -> void:
	TransScreen.transition()
	await TransScreen.on_transition_finish
	get_tree().change_scene_to_file("res://scenes/Menu/menu_lobby.tscn")

func _on_timer_mob_timeout():
	mob_timer_warn = true
