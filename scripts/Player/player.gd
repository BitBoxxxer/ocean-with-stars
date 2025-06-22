extends CharacterBody2D

class_name Player

@export var SPEED = 100.0
@export var JUMP_VELOCITY = -350 
@export var DOUBLE_JUMP_VELOCITY = -250  # Новая переменная для скорости двойного прыжка, можно настроить
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation_player = $"Player_Anim_Sprite/AnimationPlayer"
@onready var animated_sprite = $"Player_Anim_Sprite"

@onready var animated_interact_player = $"Player_Anim_Interact_Sprite/AnimationPlayer"
@onready var animated_interact_sprite = $"Player_Anim_Interact_Sprite"

@onready var attack_area: Area2D = $AttackArea
@onready var attack_cooldown_timer: Timer = $AttackCooldownTimer

@export var attack_cooldown_time: float = 0.5

var jumps_left = 2 # Отслеживаем, сколько прыжков осталось. 2 для двойного прыжка.

func _ready():
	animated_interact_sprite.visible = false
	animation_player.play("RESET")
	DoorsManager.on_trigger_player_spawn.connect(_on_spawn)
	print("Игрок готов. здоровье: ", Specifications.health_count)

	attack_cooldown_timer.wait_time = attack_cooldown_time
	attack_cooldown_timer.one_shot = true
	attack_cooldown_timer.stop()

	attack_area.set_deferred("monitoring", false)
	attack_area.set_deferred("monitorable", false)

func _process(delta):
	animated_interact_sprite.flip_h = !animated_sprite.flip_h

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		# Если игрок на земле, сбросьте счетчик прыжков
		jumps_left = 2

	# Проверяем на прыжок
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			jumps_left = 1 # После первого прыжка остается один
		elif jumps_left == 1: # Если не на земле и есть один прыжок в запасе (то есть, это второй прыжок)
			velocity.y = DOUBLE_JUMP_VELOCITY # Используем скорость для двойного прыжка
			jumps_left = 0 # Больше прыжков не осталось

	if Input.is_action_just_pressed("attack") and attack_cooldown_timer.is_stopped():
		_perform_attack()

	var current_speed = SPEED
	if Input.is_action_pressed("run"):
		current_speed *= 1.5

	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * current_speed
		if not animation_player.is_playing() or animation_player.current_animation != "walk":
			animation_player.play("walk")

		animated_sprite.flip_h = direction < 0
		animated_interact_sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed * delta)
		if not animation_player.is_playing() or animation_player.current_animation != "RESET":
			animation_player.play("RESET")
			velocity.x = 0
	move_and_slide()

func _on_spawn(_direction: String):
	global_position = position

func take_damage(amount: int) -> void:
	Specifications.player_take_damage(amount)
	if Specifications.health_count <= 0:
		_die()

func _die() -> void:
	print("Игрок умер!")
	# **Новое**: Проиграть звук смерти перед переходом сцены
	if AudioStreamPlayerDeath:
		AudioStreamPlayerDeath.play()
	TransScreen.transition()
	await TransScreen.on_transition_finish
	get_tree().change_scene_to_file("res://scenes/Menu/Player_Die.tscn")

func _perform_attack() -> void:
	animated_interact_sprite.visible = true
	print("Игрок выполняет атаку!")
	animated_interact_player.play("attack")

	# Enable AttackArea to detect enemies
	attack_area.set_deferred("monitoring", true)
	attack_area.set_deferred("monitorable", true)

	await get_tree().create_timer(0.2).timeout # This is the duration the AttackArea is active

	# Now get the overlapping bodies while monitoring is still active
	var bodies_hit = attack_area.get_overlapping_bodies()
	for body in bodies_hit:
		if body is Enemy: # Using class_name Enemy
			if body.has_method("take_damage"):
				body.take_damage(Specifications.player_attack_damage)
				print("Игрок нанес урон врагу!")
	
	# Disable AttackArea after checking for hits
	attack_area.set_deferred("monitoring", false)
	attack_area.set_deferred("monitorable", false)

	attack_cooldown_timer.start()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	animated_interact_sprite.visible = false
