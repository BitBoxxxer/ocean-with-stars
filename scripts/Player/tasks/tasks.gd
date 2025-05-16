extends Node
class_name QuestManager

@onready var Q_Box: CanvasLayer = UI_PlayerScreen.get_node('Tasks')
@onready var Q_Desc: RichTextLabel = UI_PlayerScreen.get_node('Tasks/Panel/VBoxContainer/Desc')
@onready var Q_Title: RichTextLabel = UI_PlayerScreen.get_node('Tasks/Panel/VBoxContainer/Title')

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
