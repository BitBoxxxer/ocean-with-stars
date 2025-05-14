extends Node2D

var inventory =[]

signal inventory_update
var player_node: Node = null

func _ready():
	inventory.resize(30)

func add_items(item):
	for i in range(inventory.size()):
		if inventory[i] != null and inventory[i]["type"] == item["type"]:
			inventory[i]["quantity"] == item["quantity"]
			inventory_update.emit()
			return true
		elif inventory[i] == null:
			inventory[i] = item
			inventory_update.emit()
			return true
		return false

func remove_items():
	inventory_update.emit()
