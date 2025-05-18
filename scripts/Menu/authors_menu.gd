extends Control

@onready var Animated = get_node("Another/Container/RichTextLabel/AnimationPlayer")
@onready var RichTxtLab = get_node("Another/Container/RichTextLabel")
@onready var Video_pl = get_node("Another/Container/VideoStreamPlayer2")

var texts = [
	"Аниматор тоже Кейс.",
	"И дизайнер Кейс...",
	"И звукорежисер...",
	":D",
	"Боже чел иди играй в роблокс, если тебе так нравится заниматься фигней",
	"Мама ама криминал..."
]
var count = 0

func _on_a_back_butt_pressed():
	TransScreen.transition()
	await TransScreen.on_transition_finish
	get_tree().change_scene_to_file("res://scenes/Menu/menu_lobby.tscn")

func _on_new_text_butt_pressed() -> void:
	$Another/New_TextButt.visible = false
	if count < texts.size():
		RichTxtLab.text += texts[count] + "\n"
		Animated.play("New_text")
	else:
		Video_pl.play()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "New_text":
		count += 1
		if count < texts.size() + 1:
			$Another/New_TextButt.visible = true
