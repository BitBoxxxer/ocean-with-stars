extends Node

@onready var health = $Indicators/Panel/VBoxContainer/health
@onready var money = $Indicators/Panel/VBoxContainer/money
@onready var exp = $Indicators/Panel/VBoxContainer/exp

@onready var home_button = $CanvasLayer/VBoxContainer/Button
@onready var run_button = $CanvasLayer/run
@onready var interact_button = $CanvasLayer/interact
@onready var attack_button = $CanvasLayer/attack
@onready var jump_button = $CanvasLayer/jump

# Нам больше не нужна прямая ссылка на player_node, если мы имитируем действия!
# @onready var player_node: Player = null

func _ready():
	run_button.button_up.connect(_on_run_button_released) # Добавляем для отпускания кнопки бега

func _process(_delta):
	health.text = "жизней: " + str(Specifications.health_count)
	money.text = "денег: " + str(Specifications.money_count)
	exp.text = "опыта: " + str(Specifications.exp_count)

	if Input.is_action_just_pressed("Menu"):
		TransScreen.transition()
		await TransScreen.on_transition_finish
		get_tree().change_scene_to_file("res://scenes/Player/WindowsInGame/window_in_game_menu.tscn")

# ... (функции save() и load_game() остаются без изменений) ...

func _on_home_button_pressed() -> void:
	TransScreen.transition()
	await TransScreen.on_transition_finish
	get_tree().change_scene_to_file("res://scenes/Player/WindowsInGame/window_in_game_menu.tscn")

# **Измененные функции для имитации действий Input Map**

func _on_run_pressed() -> void:
	# Имитируем нажатие действия "run"
	Input.action_press("run")
	print("Кнопка 'Бежать' нажата (имитация действия 'run')!")

func _on_run_button_released() -> void:
	# Имитируем отпускание действия "run"
	Input.action_release("run")
	print("Кнопка 'Бежать' отпущена (имитация отпускания 'run')!")


func _on_interact_pressed() -> void:
	# Имитируем нажатие действия "activate" (или "interact", если такое есть)
	# Используй имя действия, которое соответствует взаимодействию в твоем Input Map.
	Input.action_press("activate")
	# Так как взаимодействие обычно одноразовое, можно сразу "отпустить" его
	Input.action_release("activate")
	print("Кнопка 'Взаимодействовать' нажата (имитация действия 'activate')!")

func _on_attack_pressed() -> void:
	# Имитируем нажатие действия "attack"
	Input.action_press("attack")
	# Так как атака обычно одноразовая, можно сразу "отпустить" ее,
	# или пусть ее обработает игровой цикл, а потом отпустится.
	# Если атака имеет cooldown, то `Input.is_action_just_pressed` в игроке
	# сам позаботится о том, чтобы не повторять ее слишком часто.
	Input.action_release("attack") # Можно попробовать убрать, если атака должна быть "удерживаемой"
	print("Кнопка 'Атаковать' нажата (имитация действия 'attack')!")

func _on_jump_pressed() -> void:
	# Имитируем нажатие действия "jump"
	Input.action_press("jump")
	# Прыжок обычно одноразовый, поэтому сразу отпускаем
	Input.action_release("jump")
	print("Кнопка 'Прыжок' нажата (имитация действия 'jump')!")
