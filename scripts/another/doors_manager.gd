extends Node

const scene_lobby = preload("res://scenes/Maps/lobby.tscn")
const scene_tutorial = preload("res://scenes/Maps/tutorial.tscn")

signal on_trigger_player_spawn

var spawn_door_tag

func go_to_level(level_tag, dest_tag):
	var scene_to_load
	
	match level_tag:
		"lobby":
			scene_to_load = scene_lobby
		"level_1":
			scene_to_load = scene_tutorial
			
	if scene_to_load != null:
		spawn_door_tag = dest_tag
		get_tree().change_scene_to_packed(scene_to_load)

func trigger_player_spawn(position: Vector2, direction: String):
	on_trigger_player_spawn.emit(position, direction)
