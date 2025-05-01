extends Camera2D

@onready var player = $"../Player"
@export var speed = 5

func _physics_process(_delta):
	position = player.position
