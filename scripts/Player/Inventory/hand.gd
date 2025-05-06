extends Node2D

@onready var item_icon = $item_icon
@onready var inv = $".."

var can_drop = true
var item : Dictionary
var item_count = 0

func _physics_process(delta):
	global_position = get_global_mouse_position()

func _input(event):
	if event.is_action_pressed("left_mouse"):
		if can_drop:
			drop_item()

func add_item(new_item, count):
	item = new_item
	item_count = count
	item_icon.texture = item['inv_icon']

func drop_item():
	if item != {}:
		for i in item_count:
			var instance = load(item['item_path']).instantiate()
			instance.global_position = get_global_mouse_position()
			$"../".add_child(instance)
	
	item_icon.texture = null
	item = {}
	item_count = 0

func add_items(new_item, slot_count, slot_num):
	if new_item !={}:
		if item['name'] != new_item['name']:
			return
	
	if new_item == {}:
		new_item = item
	
	var amnt = min(item_count, new_item['stack_amnt']-slot_count)
	
	if amnt >= item_count:
		item_icon.texture = null
		item = {}
		item_count = 0
	else:
		item_count -= amnt
	
	for i in amnt:
		inv.items[slot_num.x][slot_num.y].add_item(new_item)
