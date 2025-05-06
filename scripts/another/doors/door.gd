extends Area2D

class_name Door

@export var destination_level_tag: String
@export var destination_door_tag: String
@export var spawn_direction = "up"
@onready var animation_player = $Sprite2D/AP

var player_in_area = false

func _ready():
	if animation_player:
		animation_player.play("RESET")

func _process(_delta):
	if player_in_area and Input.is_action_just_pressed("next"):
		DoorsManager.call_deferred("go_to_level", destination_level_tag, destination_door_tag)

func _on_body_entered(body):
	if body is Player:
		player_in_area = true
		if animation_player:
			animation_player.play("open")

func _on_body_exited(body):
	if body is Player:
		player_in_area = false
		if animation_player:
			animation_player.play("RESET")
