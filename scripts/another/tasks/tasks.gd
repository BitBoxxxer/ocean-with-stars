extends Node
class_name QuestManager

var scene_instance_UI = load("res://scenes/Player/Player_UI_Screen.tscn").instantiate()

@onready var Q_Box: CanvasLayer = scene_instance_UI.get_node('Tasks')
@onready var Q_Desc: RichTextLabel = scene_instance_UI.get_node('Tasks/Panel/VBoxContainer/Desc')
@onready var Q_Title: RichTextLabel = scene_instance_UI.get_node('Tasks/Panel/VBoxContainer/Title')
@export_group("Quest Settings")
@export var quest_name: String
@export var quest_desc: String
@export var reached_goal_text: String

enum QuestStatus{
	available,
	started,
	reached_goal,
	finished,
}

@export var quest_status: QuestStatus = QuestStatus.available

@export_group("Reward Settings")
@export var reward_amount: int
@export var money_amount: int
