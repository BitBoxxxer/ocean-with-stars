extends Node

@export var root_path : NodePath

@onready var sounds = {
	&"UI_Hover" : AudioStreamPlayer.new(),
	&"UI_Click" : AudioStreamPlayer.new(),
	}

func _ready():
	assert(root_path != null, "Пустой путь к Интерфейсу звуков кнопок")
	for i in sounds.keys():
		sounds[i].stream = load("res://visuals/vis_mp3_butts/" + str(i) + ".mp3")
		sounds[i].bus = &"Sfx"
		add_child(sounds[i])
	install_sounds(get_node(root_path))

func install_sounds(node: Node):
	for i in node.get_children():
		if i is Button:
			i.mouse_entered.connect( ui_sfx_play.bind(&"UI_Hover"))
			i.pressed.connect(ui_sfx_play.bind(&"UI_Click"))
		install_sounds(i)

func ui_sfx_play(sound: String):
	sounds[sound].play()
