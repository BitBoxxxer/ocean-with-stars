extends CharacterBody2D

var player_in_area = false
const SPEED = 50.0
@onready var timer = $"Timer"

#func _physics_process(delta):
	#var direction = (Player.position-position).normalized()
	#velocity = direction * SPEED
	#look_at(Player.position)
	#move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		print('ok!')
		player_in_area = true
		timer.start()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		print('u go away!')
		player_in_area = false
		timer.stop()


func _on_timer_timeout() -> void:
	Specifications.health_count += 1
	queue_free()
	print(Specifications.health_count)
	print(get_tree().current_scene.name)
	SaveLoadManager.save_file()
