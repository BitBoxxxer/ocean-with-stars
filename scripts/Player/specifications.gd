extends Node

# данные игрока:
@export var User_Name = ""
@export var health_count = 30
@export var max_health_count = 30
@export var money_count = 0
@export var exp_count = 0

# данные врагов:
@export var enemy1_health_count = 6
@export var enemy1_money_count = 0 # пусть будут выпадать игроку деньги


# скриптов системы:
@export var world_load_file_ID: int

@export var warning_window_type: int
signal new_game_load

# сигнал для уведомления об изменении здоровья
signal player_health_changed(new_health: int)

# Функция для получения урона, которая обновляет глобальную переменную
func player_take_damage(amount: int) -> void:
	health_count -= amount
	if health_count < 0:
		health_count = 0
	player_health_changed.emit(health_count) # Отправляем сигнал об изменении здоровья
	print("Глобальное здоровье игрока: ", health_count)
	if health_count <= 0:
		print("Игрок умер (глобально)!")
		
		# Здесь можно добавить логику Game Over, если вы управляете ею глобально
