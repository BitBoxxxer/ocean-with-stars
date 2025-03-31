extends Control

@onready var Animated = get_node("AnimationPlayer")
@onready var HideButton = get_node("Hide_Butt")
@onready var FromStartButts = get_node("FromStartButts")
@onready var PanelBlock = get_node("PanelBlock")

func _ready():
	HideButton.visible = false
	FromStartButts.visible = false
	PanelBlock.visible = false

func _on_start_butt_pressed():
	PanelBlock.visible = true
	Animated.play("Playing")
	FromStartButts.visible = true

func _on_hide_butt_pressed():
	HideButton.hide()
	PanelBlock.visible = false
	Animated.play("FlyAway")

func _on_animation_player_animation_finished(anim_name):
	if (anim_name == "Playing"):
		HideButton.show()
	if (anim_name == "FlyAway"):
		FromStartButts.visible = false

func _on_options_butt_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/sce_menu/options_menu.tscn")

func _on_authors_butt_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/sce_menu/authors_menu.tscn")

func _on_achievements_butt_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/sce_menu/achievements_menu.tscn")

func _on_debug_butt_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Maps/world_map_debug.tscn")

func _on_new_game_butt_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/talkative_scene.tscn")

func _on_continue_butt_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/talkative_scene.tscn")
