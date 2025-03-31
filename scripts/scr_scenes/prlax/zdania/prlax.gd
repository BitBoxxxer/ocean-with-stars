extends Sprite2D

@export var layer = 1
var speedOffset = 0.5
@onready var player = $"../../Player"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x = -player.position.x * layer * speedOffset
