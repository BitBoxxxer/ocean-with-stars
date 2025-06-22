extends Resource
class_name CustomItem 

@export var id: String = "" # Уникальный ID предмета (например, "apple", "sword_basic")
@export var item_name : String = "" # Изменено с 'name' на 'item_name' для избежания конфликтов
@export_enum("Tool", "Food", "Weapon", "Consumable", "Material", "QuestItem") var type: String = "Tool" # Расширил типы
@export var description: String = "" # Добавим описание
@export var inv_icon: Texture2D # Иконка для инвентаря
@export var world_scene: PackedScene # Сцена, которая будет спавниться в мире (например, 3D модель)
@export var max_stack_amount: int = 1 # Максимальное количество в одном слоте (было stack_amnt)
@export var price: float = 0.0 # Цена предмета

func _init():
	if id.is_empty() and resource_path:
		id = resource_path.get_file().get_basename()
