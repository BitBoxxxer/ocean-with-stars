extends Control


const ANIMATION_PLAYER_PATH = "RichTextLabel/AnimationPlayer"
@onready var Animated = get_node(ANIMATION_PLAYER_PATH)
const CBANIMATION_PLAYER_PATH = "ContinueButt/CBAnimationPlayer"
@onready var CBAnimated = get_node(CBANIMATION_PLAYER_PATH)

var speed_scale_normal = 0.5

func _ready():
	$RichTextLabel.text = _textFirst
	$LoadLvlButt.visible = false
	$ContinueButt.visible = false
	Animated.play("example")

func _on_button_pressed():
	Animated.speed_scale = 5
	$SpeedButt.visible = false

func _on_continue_butt_pressed():
	$ContinueButt.visible = false
	Animated.play(&"RESET")
	
func _on_load_lvl_butt_pressed():
	get_tree().change_scene_to_file("res://scenes/Maps/tutorial_scene.tscn")
	#$TransScreen.transitioned

func _on_trans_screen_transitioned() -> void:
	pass # Replace with function body.

func _on_animation_player_animation_finished(anim_name):
	if (anim_name == "example"):
		CBAnimated.play("PlayingButtNext")
		$ContinueButt.visible = true
		
	elif (anim_name == &"RESET"):
		$SpeedButt.visible = true
		
		Animated.speed_scale = speed_scale_normal
		$RichTextLabel.text = _textSecond
		Animated.play("exampleSecond")
		
	elif (anim_name == "exampleSecond"):
		$LoadLvlButt.visible = true


const _textFirst = "— Все эти годы подготовки, все тренировки, все разговоры о том, как мы справимся 
с любыми трудностями... 
И что? Я не могу [color=yellow]даже[/color] поймать сигнал. 
Как будто вся моя жизнь, вся моя команда... [color=yellow]просто исчезла[/color].
[shake rate=20.0 level=5 connected=1] \n\nЯ не могу поверить, что это происходит [color=yellow]на самом деле[/color].[/shake]"

const _textSecond = "Сквозь эту пустоту Вы замечаете что-то впереди — [color=yellow]обломок[/color]. Ваше сердце замирает, 
когда Вы осознаете, что это, вероятно, [color=yellow]часть Вашей станции[/color]. Вы поднимаете голову и видите, как куски металла медленно вращаются в безвоздушном пространстве, оставляя за собой следы искр и дыма. 
\nОбломок догорает, его поверхность покрыта черными пятнами, а красные языки пламени вырываются из щелей, как будто сама станция пытается вырваться из объятий смерти."
