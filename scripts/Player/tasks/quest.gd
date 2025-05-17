class_name Quest
extends QuestManager

func start_quest() -> void:
	if quest_status == QuestStatus.available:
		quest_status = QuestStatus.started
		Q_Box.visible = true
		Q_Title.text = quest_name
		Q_Desc.text = quest_desc

func reached_goal() -> void:
	if quest_status == QuestStatus.started:
		quest_status = QuestStatus.reached_goal
		Q_Desc.text = reached_goal_text

func finish_quest() -> void:
	if quest_status == QuestStatus.reached_goal:
		quest_status = QuestStatus.finished
		Q_Box.visible = false
		scene_instance_UI.money_count += money_amount
