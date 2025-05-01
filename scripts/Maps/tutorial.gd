extends Node2D

func _ready():
	if DoorsManager.spawn_door_tag != null:
		_on_level_spawn(DoorsManager.spawn_door_tag)

func _on_level_spawn(dest_tag: String):
	var door_path = "Doors/Door_" + dest_tag
	var door = get_node(door_path) as Door
	DoorsManager.trigger_player_spawn(door.spawn.global_position, door.spawn_direction)
###
