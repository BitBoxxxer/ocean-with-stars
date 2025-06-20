extends CharacterBody2D

class_name Enemy # Явно указываем class_name для лучшей организации

@export var speed: float = 70.0 # Скорость врага
@export var jump_velocity: float = -400.0 # Если враг умеет прыгать
@export var attack_damage: int = 5 # Урон, наносимый врагом
@export var attack_cooldown: float = 2.5 # Время перезарядки атаки в секундах

@onready var timer: Timer = $Timer # Используется для гравитации или других таймеров, если нужно
@onready var area_see: Area2D = $AreaSee # Узел Area2D для обнаружения игрока
@onready var area_attack: Area2D = $AreaAttack # Узел Area2D для зоны атаки
@onready var attack_timer: Timer = $AttackTimer # Таймер для перезарядки атаки

var player_in_sight: CharacterBody2D = null # Ссылка на игрока, если он в AreaSee
var is_attacking: bool = false # Флаг, указывающий, атакует ли враг

func _ready() -> void:
	# Подключаем сигналы Area2D
	area_see.body_entered.connect(_on_area_see_body_entered)
	area_see.body_exited.connect(_on_area_see_body_exited)
	area_attack.body_entered.connect(_on_area_attack_body_entered)
	area_attack.body_exited.connect(_on_area_attack_body_exited)

	# Устанавливаем время перезарядки атаки для таймера
	attack_timer.wait_time = attack_cooldown
	attack_timer.one_shot = true # Таймер будет срабатывать один раз после запуска

func _physics_process(delta: float) -> void:
	# Применяем гравитацию
	if not is_on_floor():
		velocity.y += gravity * delta

	# Логика поведения врага
	if player_in_sight:
		# Игрок в зоне видимости, преследуем его
		var direction_to_player = (player_in_sight.global_position - global_position).normalized()
		
		# Если игрок не в зоне атаки, двигаемся к нему по горизонтали
		if not is_player_in_attack_range():
			velocity.x = direction_to_player.x * speed
		else:
			# Игрок в зоне атаки, останавливаемся и атакуем
			velocity.x = move_toward(velocity.x, 0, speed) # Останавливаем горизонтальное движение
			if not is_attacking and attack_timer.is_stopped():
				_attack_player()
	else:
		# Игрока нет в зоне видимости, останавливаемся (или реализуем патрулирование)
		velocity.x = move_toward(velocity.x, 0, speed) # Замедление до остановки
	if 
	move_and_slide()

# --- Функции обнаружения и атаки ---

func _on_area_see_body_entered(body: Node2D) -> void:
	if body is Player: # Проверяем, является ли вошедший объект игроком
		player_in_sight = body
		print("Игрок обнаружен!")

func _on_area_see_body_exited(body: Node2D) -> void:
	if body is Player:
		player_in_sight = null
		print("Игрок потерян из виду.")

func _on_area_attack_body_entered(body: Node2D) -> void:
	# Этот сигнал может помочь в определении момента для атаки
	# Но основная логика атаки будет в _physics_process
	pass

func _on_area_attack_body_exited(body: Node2D) -> void:
	pass

func _attack_player() -> void:
	if player_in_sight and is_player_in_attack_range():
		is_attacking = true
		print("Враг атакует игрока!")
		
		# Вызов функции получения урона у игрока
		# Убедитесь, что у вашего игрока есть функция `take_damage`
		if player_in_sight.has_method("take_damage"):
			player_in_sight.take_damage(attack_damage)
		
		attack_timer.start() # Запускаем таймер перезарядки
		await attack_timer.timeout # Ждем завершения перезарядки
		is_attacking = false
		print("Перезарядка атаки завершена.")


func is_player_in_attack_range() -> bool:
	# Проверяем, находится ли игрок в зоне AreaAttack
	# Это можно сделать, проверив, какие тела перекрываются с AreaAttack
	var overlapping_bodies = area_attack.get_overlapping_bodies()
	for body in overlapping_bodies:
		if body is Player:
			return true
	return false

# --- Вспомогательные функции ---

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Добавьте это, если хотите, чтобы враг мог быть поражен
func take_damage(amount: int) -> void:
	# Здесь можно добавить логику уменьшения здоровья врага, анимацию урона и т.д.
	print("Враг получил урон: ", amount)
	# Пример: health -= amount
	# if health <= 0: queue_free()
