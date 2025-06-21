extends CharacterBody2D

class_name Player

@export var SPEED = 100.0
@export var JUMP_VELOCITY = -500
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation_player = $"Sprite2D/AnimationPlayer"
@onready var animated_sprite = $"Sprite2D"

func _ready():
	animation_player.play("RESET")
	DoorsManager.on_trigger_player_spawn.connect(_on_spawn)
	# Подключаемся к сигналу изменения здоровья из глобального файла (если нужно обновлять UI и т.д.)
	# PlayerStats.player_health_changed.connect(_on_player_health_changed)
	print("Игрок готов! Глобальное здоровье: ", Specifications.health_count)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var current_speed = SPEED
	if Input.is_action_pressed("run"):
		current_speed *= 1.5

	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * current_speed
		if not animation_player.is_playing() or animation_player.current_animation != "walk":
			animation_player.play("walk")

		animated_sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed * delta)
		if not animation_player.is_playing() or animation_player.current_animation != "RESET":
			animation_player.play("RESET")
			velocity.x = 0
	move_and_slide()

func _on_spawn(_direction: String):
	global_position = position

# --- Функция для получения урона, использующая глобальный файл ---
func take_damage(amount: int) -> void:
	Specifications.player_take_damage(amount) # Вызываем функцию из глобального файла
	if Specifications.health_count <= 0:
		_die() # Вызываем функцию смерти игрока

func _die() -> void:
	print("Игрок умер!")
	TransScreen.transition()
	await TransScreen.on_transition_finish
	get_tree().change_scene_to_file("res://scenes/Menu/Player_Die.tscn")
