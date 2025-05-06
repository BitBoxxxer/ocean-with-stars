extends Node2D

@onready var inv = $".."

@onready var item_icon = $icon
@onready var item_count_label = $itemCount

@onready var hand = $"../hand"

var slot_num: Vector2i
var item: Dictionary
var item_count = 0

func add_item(new_item):
	if (item_count != 0 and (item['name'] == new_item['name']) and item_count < item['stack_amnt']) or item == {}:
		item_count += 1
		item = new_item
		item_icon.texture = item['inv_icon']
		refresh_label()
		return true
	
	return false

func refresh_label():
	item_count_label.text = str(item_count)


func _on_button_pressed() -> void:
	if hand.item == {} and item != {}:
		inv.remove_stack(slot_num)
	
	elif hand.item!= {}:
		hand.add_items(item, item_count, slot_num)


func _on_button_mouse_entered() -> void:
	hand.can_drop = false


func _on_button_mouse_exited() -> void:
	hand.can_drop = true
