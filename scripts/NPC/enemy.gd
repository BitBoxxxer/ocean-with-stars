extends CharacterBody2D

const Player = preload("res://scripts/Player/player.gd")

const SPEED = 50.0

func _physics_process(delta):
	var direction = (Player.position-position).normalized()
	velocity = direction * SPEED
	look_at(Player.position)
	move_and_slide()
