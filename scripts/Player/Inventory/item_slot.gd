# res://scenes/Player/inventory/ItemSlot.tscn (Добавь дочерние узлы в сцену)
# - TextureRect (название: ItemIcon)
# - Label (название: ItemCountLabel)

# res://scenes/Player/inventory/ItemSlot.gd
extends Control # Лучше использовать Control для UI элементов
class_name ItemSlot
@export var slot_num : Vector2i # Позиция слота в сетке инвентаря (x, y)

@onready var item_icon: TextureRect = $ItemIcon
@onready var item_count_label: Label = $ItemCountLabel

var current_item: Item = null # Ссылка на объект Item (ресурс)
var item_quantity: int = 0 # Количество этого предмета в слоте

func _ready():
	update_display()

# Обновляет визуальное отображение слота
func update_display():
	if current_item:
		item_icon.texture = current_item.inv_icon
		item_icon.visible = true
		if current_item.max_stack_amount > 1: # Если предмет стакается
			item_count_label.text = str(item_quantity)
			item_count_label.visible = true
		else:
			item_count_label.visible = false # Не показываем количество для нештабелируемых
	else:
		item_icon.texture = null
		item_icon.visible = false
		item_count_label.visible = false
		item_count_label.text = ""

# Устанавливает предмет в слот
func set_item(item_resource: Item, quantity: int):
	current_item = item_resource
	item_quantity = quantity
	update_display()

# Очищает слот
func clear_slot():
	current_item = null
	item_quantity = 0
	update_display()

# Добавляет количество к предмету в слоте
func add_quantity(amount: int) -> int: # Возвращает количество, которое не удалось добавить
	if current_item == null or current_item.max_stack_amount == 0:
		return amount # Некуда добавлять или нештабелируемый (хотя max_stack_amount обычно > 0)

	var space_available = current_item.max_stack_amount - item_quantity
	var quantity_to_add = min(amount, space_available)

	item_quantity += quantity_to_add
	update_display()

	return amount - quantity_to_add # Возвращаем остаток, который не влез

# Удаляет количество из предмета в слоте
func remove_quantity(amount: int) -> int: # Возвращает количество, которое не удалось удалить (если удаляли больше, чем есть)
	var removed_amount = min(amount, item_quantity)
	item_quantity -= removed_amount
	update_display()
	if item_quantity <= 0:
		clear_slot()
	return amount - removed_amount # Возвращаем остаток, который не удалось удалить
