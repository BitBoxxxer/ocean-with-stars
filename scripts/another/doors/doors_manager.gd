extends Node

const scene_lobby = ("res://scenes/Maps/lobby.tscn")
const scene_tutorial = ("res://scenes/Maps/tutorial.tscn")
const scene_shop = ("res://scenes/Maps/shop.tscn")

signal on_trigger_player_spawn

var spawn_door_tag

func go_to_level(level_tag, dest_tag):
	var scene_to_load
	
	match level_tag:
		"lobby":
			scene_to_load = scene_lobby
		"tut":
			scene_to_load = scene_tutorial
		"shop":
			scene_to_load = scene_shop
		
	if scene_to_load != null:
		TransScreen.transition()
		await TransScreen.on_transition_finish
		spawn_door_tag = dest_tag
		get_tree().change_scene_to_file(scene_to_load)

func trigger_player_spawn(position: Vector2, direction: String):
	on_trigger_player_spawn.emit(position, direction)
