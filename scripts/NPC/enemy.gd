extends CharacterBody2D

class_name Enemy

@export var speed: float = 70.0
@export var jump_velocity: float = -400.0
@export var attack_damage: int = 5
@export var attack_cooldown: float = 2.5
@export var enemy_max_health: int = 6
@export var money_on_death: int = 10

@onready var area_see: Area2D = $AreaSee
@onready var area_attack: Area2D = $AreaAttack
@onready var attack_timer: Timer = $AttackTimer
@onready var healse_Label: Label = $Health
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var main_sprite = $Sprite2D

var player_in_sight: CharacterBody2D = null
var is_attacking: bool = false
var current_health: int
var is_dead: bool = false

func _ready() -> void:
	animated_sprite.visible = false
	current_health = enemy_max_health
	_update_health_label()
	area_see.body_entered.connect(_on_area_see_body_entered)
	area_see.body_exited.connect(_on_area_see_body_exited)
	attack_timer.wait_time = attack_cooldown
	attack_timer.one_shot = true
	if animated_sprite:
		animated_sprite.animation_finished.connect(_on_animated_sprite_animation_finished)

func _physics_process(delta: float) -> void:
	if is_dead:
		return
	if not is_on_floor():
		velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta
	if not is_attacking and player_in_sight:
		var direction_to_player_x = player_in_sight.global_position.x - global_position.x
		if is_player_in_attack_range():
			velocity.x = move_toward(velocity.x, 0, speed)
			if attack_timer.is_stopped():
				_attack_player()
		else:
			velocity.x = sign(direction_to_player_x) * speed
			if animated_sprite:
				animated_sprite.flip_h = direction_to_player_x < 0
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	# Эта часть отвечает за переворот спрайта по оси X
	if velocity.x != 0:
		animated_sprite.flip_h = velocity.x < 0
		main_sprite.flip_h = velocity.x < 0 # Эта строка также была в вашем коде
		
	move_and_slide()

func _update_health_label() -> void:
	healse_Label.text = str(current_health)

func _on_area_see_body_entered(body: Node2D) -> void:
	if body is Player:
		player_in_sight = body

func _on_area_see_body_exited(body: Node2D) -> void:
	if body is Player:
		player_in_sight = null
		print("Игрок потерян из виду.")

func _attack_player() -> void:
	if is_dead or not player_in_sight or not is_player_in_attack_range():
		return
	is_attacking = true
	if animated_sprite:
		animated_sprite.visible = true
		animated_sprite.flip_h = (player_in_sight.global_position.x - global_position.x) < 0
		animated_sprite.sprite_frames.set_animation_loop("attack", false)
		animated_sprite.play("attack")
	attack_timer.start()
	if player_in_sight.has_method("take_damage"):
		player_in_sight.take_damage(attack_damage)

func is_player_in_attack_range() -> bool:
	for body in area_attack.get_overlapping_bodies():
		if body is Player:
			return true
	return false

func take_damage(amount: int) -> void:
	if is_dead: return
	current_health -= amount
	_update_health_label()
	if current_health <= 0:
		_die()
	else:
		if animated_sprite:
			animated_sprite.modulate = Color.RED
			get_tree().create_timer(0.2).timeout.connect(func(): animated_sprite.modulate = Color.WHITE)

func _die() -> void:
	if is_dead: return
	is_dead = true
	set_physics_process(false)
	get_node_or_null("CollisionShape2D").call_deferred("set_disabled", true)
	area_see.call_deferred("set_monitoring", false)
	area_attack.call_deferred("set_monitoring", false)
	if animated_sprite:
		animated_sprite.sprite_frames.set_animation_loop("death", false)
		animated_sprite.play("death")
	else:
		queue_free()
	if Specifications:
		Specifications.money_count += money_on_death
		print("Игрок получил ", money_on_death, " монет. Всего монет: ", Specifications.money_count)

func _on_animated_sprite_animation_finished() -> void:
	match animated_sprite.animation:
		"death":
			queue_free()
		"attack":
			is_attacking = false
			print("Перезарядка атаки началась.")
