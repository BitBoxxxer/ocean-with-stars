extends Node

# данные игрока:
@export var health_count = 20
@export var money_count = 0
@export var exp_count = 0


# Для скриптов системы:
@export var world_load_file_ID: int

@export var warning_window_type: int
signal new_game_load
