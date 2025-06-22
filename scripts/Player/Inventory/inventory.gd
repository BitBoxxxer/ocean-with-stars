# res://scenes/Player/inventory/Inventory.gd
extends Control

const ITEM_SLOT_SCENE = preload("res://scenes/Player/inventory/ItemSlot.tscn")

@export var row_size: int = 10
@export var col_size: int = 3
@export var slot_spacing: Vector2 = Vector2(50, 50)

var item_slots: Array[ItemSlot] = [] # <-- ТУТ ТЕПЕРЬ ВСЕ ХОРОШО, ItemSlot найден

func _ready():
	setup_inventory_grid()

func setup_inventory_grid():
	var grid_container = GridContainer.new()
	grid_container.columns = row_size
	# Возможно, тебе захочется управлять позицией GridContainer на экране:
	# grid_container.position = Vector2(...)
	add_child(grid_container)

	item_slots.resize(row_size * col_size)

	for y in range(col_size):
		for x in range(row_size):
			var slot_index = y * row_size + x
			var instance = ITEM_SLOT_SCENE.instantiate()
			instance.slot_num = Vector2i(x, y)
			item_slots[slot_index] = instance
			grid_container.add_child(instance)

func add_item(item_id: String, quantity: int = 1) -> bool:
	var item_resource: Item = ItemManager.get_item_by_id(item_id) # <-- ИСПОЛЬЗУЕМ ItemManager напрямую
	if item_resource == null:
		push_warning("Item with ID '%s' not found in ItemManager." % item_id)
		return false

	var remaining_quantity = quantity

	if item_resource.max_stack_amount > 1:
		for slot in item_slots:
			if slot.current_item == item_resource and slot.item_quantity < slot.current_item.max_stack_amount:
				remaining_quantity = slot.add_quantity(remaining_quantity)
				if remaining_quantity <= 0:
					return true

	if remaining_quantity > 0:
		for slot in item_slots:
			if slot.current_item == null:
				var quantity_to_add_to_new_slot = min(remaining_quantity, item_resource.max_stack_amount)
				slot.set_item(item_resource, quantity_to_add_to_new_slot)
				remaining_quantity -= quantity_to_add_to_new_slot
				if remaining_quantity <= 0:
					return true

	return remaining_quantity <= 0

func remove_item(item_id: String, quantity: int = 1) -> bool:
	var item_resource: Item = ItemManager.get_item_by_id(item_id) # <-- ИСПОЛЬЗУЕМ ItemManager напрямую
	if item_resource == null:
		push_warning("Item with ID '%s' not found in ItemManager." % item_id)
		return false

	var remaining_quantity_to_remove = quantity

	for i in range(item_slots.size() - 1, -1, -1):
		var slot = item_slots[i]
		if slot.current_item == item_resource:
			var removed_from_slot = min(remaining_quantity_to_remove, slot.item_quantity)
			slot.remove_quantity(removed_from_slot)
			remaining_quantity_to_remove -= removed_from_slot
			if remaining_quantity_to_remove <= 0:
				return true

	return remaining_quantity_to_remove <= 0

func has_item(item_id: String) -> bool:
	var item_resource: Item = ItemManager.get_item_by_id(item_id) # <-- ИСПОЛЬЗУЕМ ItemManager напрямую
	if item_resource == null:
		return false
	for slot in item_slots:
		if slot.current_item == item_resource and slot.item_quantity > 0:
			return true
	return false

func get_item_count(item_id: String) -> int:
	var count = 0
	var item_resource: Item = ItemManager.get_item_by_id(item_id) # <-- ИСПОЛЬЗУЕМ ItemManager напрямую
	if item_resource == null:
		return 0
	for slot in item_slots:
		if slot.current_item == item_resource:
			count += slot.item_quantity
	return count

func get_first_empty_slot() -> ItemSlot:
	for slot in item_slots:
		if slot.current_item == null:
			return slot
	return null
