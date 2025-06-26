extends Node

@onready var health = $Indicators/Panel/VBoxContainer/health
@onready var money = $Indicators/Panel/VBoxContainer/money
@onready var exp = $Indicators/Panel/VBoxContainer/exp

@onready var home_button = $CanvasLayer/VBoxContainer/Button
@onready var run_button = $CanvasLayer/run
@onready var interact_button = $CanvasLayer/interact
@onready var attack_button = $CanvasLayer/attack
@onready var jump_button = $CanvasLayer/jump

var is_running: bool = false

func _ready():
	run_button.pressed.connect(_on_run_toggled)


func _process(_delta):
	health.text = "жизней: " + str(Specifications.health_count)
	money.text = "денег: " + str(Specifications.money_count)
	exp.text = "опыта: " + str(Specifications.exp_count)

	if Input.is_action_just_pressed("Menu"):
		TransScreen.transition()
		await TransScreen.on_transition_finish
		get_tree().change_scene_to_file("res://scenes/Player/WindowsInGame/window_in_game_menu.tscn")

func _on_home_button_pressed() -> void:
	TransScreen.transition()
	await TransScreen.on_transition_finish
	get_tree().change_scene_to_file("res://scenes/Player/WindowsInGame/window_in_game_menu.tscn")

func _on_run_toggled() -> void:
	is_running = not is_running

	if is_running:
		Input.action_press("run")
		print("Бег ВКЛЮЧЕН")
	else:
		Input.action_release("run")
		print("Бег ВЫКЛЮЧЕН")


func _on_interact_pressed() -> void:
	Input.action_press("activate")
	Input.action_release("activate")
	print("Кнопка 'Взаимодействовать' нажата (имитация действия 'activate')!")

func _on_attack_pressed() -> void:
	Input.action_press("attack")
	Input.action_release("attack")
	print("Кнопка 'Атаковать' нажата (имитация действия 'attack')!")

func _on_jump_pressed() -> void:
	Input.action_press("jump")
	Input.action_release("jump")
	print("Кнопка 'Прыжок' нажата (имитация действия 'jump')!")
