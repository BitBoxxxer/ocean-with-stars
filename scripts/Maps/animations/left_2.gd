extends Area2D

@onready var animation_player = $HoloScreen/AP
var player_in_area = false

func _ready():
	if animation_player:
		animation_player.play("RESET")

func _on_body_entered(body):
	if body is Player:
		player_in_area = true
		if animation_player:
			animation_player.play("play")

func _on_body_exited(body):
	if body is Player:
		player_in_area = false
		if animation_player:
			animation_player.play("RESET")

func _on_ap_animation_finished(_anim_name):
	if (player_in_area == true):
		if animation_player:
			animation_player.play("play")
