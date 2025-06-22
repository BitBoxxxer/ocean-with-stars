# res://singletons/ItemManager.gd
extends Node

# Словарь для хранения всех предметов, доступных по их ID
var item_database: Dictionary = {}

# Путь к папке, где хранятся твои ресурсы Item
# Убедись, что этот путь правильный!
const ITEMS_DIRECTORY = "res://scenes/Items/"

func _ready():
	load_all_items_from_directory()
	print("ItemManager: Загружено %d предметов." % item_database.size())

# Загружает все ресурсы Item из указанной директории
func load_all_items_from_directory():
	var dir = DirAccess.open(ITEMS_DIRECTORY)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".tres") or file_name.ends_with(".res"): # Проверяем расширение ресурса
				var item_path = ITEMS_DIRECTORY + file_name
				var item_resource = load(item_path)
				if item_resource is Item:
					if item_database.has(item_resource.id):
						push_warning("ItemManager: Дубликат ID предмета '%s' обнаружен. Пропускаем '%s'." % [item_resource.id, item_path])
					else:
						item_database[item_resource.id] = item_resource
				else:
					push_warning("ItemManager: '%s' не является ресурсом Item." % item_path)
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		push_error("ItemManager: Не удалось открыть директорию с предметами: %s" % ITEMS_DIRECTORY)

# Возвращает ресурс Item по его ID
func get_item_by_id(id: String) -> Item:
	if item_database.has(id):
		return item_database[id]
	push_warning("ItemManager: Предмет с ID '%s' не найден." % id)
	return null

# Создает экземпляр предмета в мире по его ID
func spawn_item_in_world(item_id: String, position: Vector3 = Vector3.ZERO) -> Node:
	var item_resource: Item = get_item_by_id(item_id)
	if item_resource and item_resource.world_scene:
		var item_instance = item_resource.world_scene.instantiate()
		if item_instance is Node3D: # Если это 3D сцена
			item_instance.global_position = position
		elif item_instance is Node2D: # Если это 2D сцена
			item_instance.global_position = Vector2(position.x, position.z) # Пример для 2D
		get_tree().current_scene.add_child(item_instance) # Добавляем в текущую сцену
		return item_instance
	elif item_resource:
		push_warning("ItemManager: Предмет '%s' не имеет указанной world_scene для спавна." % item_id)
	return null
