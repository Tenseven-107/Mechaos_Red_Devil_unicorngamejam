extends Node


onready var pause_ui = $"Pause-UI"

var main_menu: PackedScene = load("res://Scenes/Menus/MainMenu.tscn")
var active: bool = false
var can_activate: bool = true



func _ready():
	pause_ui.hide()
	pause_mode = Node.PAUSE_MODE_PROCESS

	get_tree().paused = false
	GlobalSignals.connect("dead", self, "disable")


func disable():
	can_activate = false


func _unhandled_input(event):
	if Input.is_action_just_pressed("pause") and active == false and can_activate == true:
		active = true

		pause_ui.show()
		get_tree().paused = true


func _on_Resume_button_pressed():
	active = false

	pause_ui.hide()
	get_tree().paused = false

func _on_Quit_button_pressed():
	get_tree().paused = false

	get_tree().change_scene_to(main_menu)




