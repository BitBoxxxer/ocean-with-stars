extends Node

@onready var dowload_text: RichTextLabel = $Dowload_text
@onready var galactic: VideoStreamPlayer = $Galactic
@onready var load: VideoStreamPlayer = $Load
@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $Sprite2D/AnimationPlayer

func _ready():
	timer.start()
	galactic.play()
	dowload_text.visible = true
	load.play()
	animation_player.play("eye_see")

func _on_timer_timeout():
	TransScreen.transition()
	await TransScreen.on_transition_finish
	get_tree().change_scene_to_file("res://scenes/Menu/menu_lobby.tscn")


func _on_animation_player_animation_finished(anim_name):
	animation_player.play("eye_see")
