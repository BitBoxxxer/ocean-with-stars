extends Control

@onready var Animated = get_node("Container/RichTextLabel/AnimationPlayer")
@onready var RichTxtLab = get_node("Container/RichTextLabel")
@onready var Video_pl = get_node("Container/VideoStreamPlayer2")

func _on_ready():
	$Label.visible = false

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
	get_tree().change_scene_to_file("res://scenes/sce_menu/menu.tscn")

func _on_new_text_butt_pressed() -> void:
	$New_TextButt.visible = false
	if count < texts.size():
		RichTxtLab.text += texts[count] + "\n"
		Animated.play("New_text")
	else:
		Video_pl.play()
		$Label.visible = true

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "New_text":
		count += 1
		if count < texts.size() + 1:
			$New_TextButt.visible = true
