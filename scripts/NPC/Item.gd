@tool
extends Node2D

@export var item_name = ""
@export var item_type = ""
@export var item_texture = Texture
@onready var icon_sprite = $Sprite2D
var scene_path: String = "res://scenes/NPC/Item.tscn"

var player_in_range = false

func _ready():
	if not Engine.is_editor_hint():
		icon_sprite.texture = item_texture
	
	if player_in_range and Input.is_action_just_pressed("next"):
		pickup_item()

func _process(delta):
	if Engine.is_editor_hint():
		icon_sprite.texture = item_texture

func pickup_item():
	var item = {
		"quantity": 1,
		"item_type": item_type,
		"item_name": item_name,
		"item_texture": item_texture,
		"scene_path": scene_path
	}
	#if Inventory.player_node:
		#Inventory.add_items(item)
		#self.queue_free()

func _on_area_2d_body_entered(body):
	player_in_range = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	player_in_range = false
