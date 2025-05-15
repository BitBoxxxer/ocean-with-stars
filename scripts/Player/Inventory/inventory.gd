extends Node2D

const ITEM_SLOT = preload("res://scenes/Player/inventory/ItemSlot.tscn")

var row_size = 10
var col_size = 3
var items = []

func _ready():
	for x in range(row_size):
		items.append([])
		for y in range(col_size):
			items[x].append([])
			
			var instance = ITEM_SLOT.instantiate()
			instance.global_position = Vector2(x*50,y*50)
			instance.slot_num = Vector2i(x,y)
			add_child(instance)
			items[x][y] = instance
