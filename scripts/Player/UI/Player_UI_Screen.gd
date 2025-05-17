extends Node

@onready var lives = $Indicators/Panel/VBoxContainer/lives
@onready var money = $Indicators/Panel/VBoxContainer/money
@onready var exp = $Indicators/Panel/VBoxContainer/exp

var lives_count = 20
var money_count = 0
var exp_count = 0

func _process(_delta):
	lives.text = "lives: " +str(lives_count)
	money.text = "money: " +str(money_count)
	exp.text = "exp: " +str(exp_count)
