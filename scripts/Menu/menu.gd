extends Control

@onready var Animated = get_node("Left/AnimationPlayer")
@onready var HideButton = get_node("Left/Hide_Butt")
@onready var FromStartButts = get_node("Left/FromStartButts")
@onready var PanelBlock = get_node("BG/PanelBlock")
@onready var panel_block_left: Panel = $BG/PanelBlockLeft
@onready var animation_player: AnimationPlayer = $BG/PanelBlockLeft/AnimationPlayer

func _ready():
	HideButton.visible = false
	FromStartButts.visible = false
	PanelBlock.visible = false
	panel_block_left.visible = false

func _on_start_butt_pressed():
	PanelBlock.visible = true
	panel_block_left.visible = true
	animation_player.play("Black")
	Animated.play("Playing")
	FromStartButts.visible = true

func _on_hide_butt_pressed():
	HideButton.hide()
	animation_player.play("Norm")
	Animated.play("FlyAway")

func _on_animation_player_animation_finished(anim_name):
	if (anim_name == "Playing"):
		HideButton.show()
	if (anim_name == "FlyAway"):
		FromStartButts.visible = false
		PanelBlock.visible = false
		panel_block_left.visible = false

func _on_options_butt_pressed() -> void:
	TransScreen.transition()
	await TransScreen.on_transition_finish
	get_tree().change_scene_to_file("res://scenes/Menu/options.tscn")

func _on_authors_butt_pressed() -> void:
	TransScreen.transition()
	await TransScreen.on_transition_finish
	get_tree().change_scene_to_file("res://scenes/Menu/authors.tscn")

func _on_achievements_butt_pressed() -> void:
	TransScreen.transition()
	await TransScreen.on_transition_finish
	get_tree().change_scene_to_file("res://scenes/Menu/openings.tscn")

func _on_debug_butt_pressed() -> void:
	TransScreen.transition()
	await TransScreen.on_transition_finish
	get_tree().change_scene_to_file("res://scenes/Maps/lobby.tscn")

func _on_new_game_butt_pressed() -> void:
	TransScreen.transition()
	await TransScreen.on_transition_finish
	get_tree().change_scene_to_file("res://scenes/NewGame/intro.tscn")

func _on_continue_butt_pressed() -> void:
	TransScreen.transition()
	await TransScreen.on_transition_finish
	get_tree().change_scene_to_file("res://scenes/NewGame/intro.tscn")
