extends CharacterBody2D

class_name Player

@export var SPEED = 100.0
@export var JUMP_VELOCITY = -500
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation_player = $"Sprite2D/AnimationPlayer"
@onready var animated_sprite = $"Sprite2D"

func _ready():
	animation_player.play("RESET")
	DoorsManager.on_trigger_player_spawn.connect(_on_spawn)

func _physics_process(delta): 
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		if not animation_player.is_playing() or animation_player.current_animation != "walk":
			animation_player.play("walk")
		
		animated_sprite.flip_h = direction < 0  # Переворот влево (при отрицательном направлении)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * delta)
		if not animation_player.is_playing() or animation_player.current_animation != "RESET":
			animation_player.play("RESET")
			velocity.x = 0 # чтобы не скользил.
	move_and_slide()

func _on_spawn(position: Vector2, direction: String):
	global_position = position
