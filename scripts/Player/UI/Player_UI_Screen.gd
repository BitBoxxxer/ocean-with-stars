extends Node

@onready var health = $Indicators/Panel/VBoxContainer/health
@onready var money = $Indicators/Panel/VBoxContainer/money
@onready var exp = $Indicators/Panel/VBoxContainer/exp
@onready var save_manager = preload("res://scripts/Player/save_Load.gd").new()

var health_count = 20
var money_count = 0
var exp_count = 0


func _process(_delta):
	health.text = "health: " +str(health_count)
	money.text = "money: " +str(money_count)
	exp.text = "exp: " +str(exp_count)


func _on_button_pressed() -> void:
	save_manager.save_game()
