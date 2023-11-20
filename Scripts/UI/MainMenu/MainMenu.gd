extends Node



onready var tween = $Tween
onready var transition = $Menu/Control/TransitionScreen
onready var logo = $Menu/Control/Graphics/Logo

onready var start_menu = $Menu/Control/StartMenu
onready var settings_menu = $Menu/Control/SettingsMenu

onready var start_button = $Menu/Control/StartMenu/Start_button

onready var sound = $Menu/Control/SettingsMenu/SoundSlider
onready var fullscreen = $Menu/Control/SettingsMenu/Fullsceen_check

onready var logo_pos: Vector2 = logo.rect_position 
var start_scene: PackedScene = load("res://Scenes/Menus/Building.tscn")



func _ready():
	Engine.time_scale = 1

	TempMemory.reset()

	var material = transition.material
	tween.interpolate_property(material, "shader_param/progress", 1, 0, 1,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

	settings_menu.hide()

	sound.value = AudioServer.get_bus_volume_db(0)
	fullscreen.pressed = OS.window_fullscreen


func _on_Start_button_pressed():
	var material = transition.material
	tween.interpolate_property(material, "shader_param/progress", 0, 1, 1,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

	start_button.release_focus()
	transition.mouse_filter = Control.MOUSE_FILTER_STOP

	tween.connect("tween_all_completed", self, "next_scene")

func next_scene():
	get_tree().change_scene_to(start_scene)


func _on_Setting_button_pressed():
	start_menu.hide()
	settings_menu.show()

	tween.interpolate_property(logo, "rect_position", logo_pos, Vector2.UP * 400, 1, 
	Tween.TRANS_BOUNCE, Tween.EASE_OUT_IN)
	tween.start()


func _on_Quit_button_pressed():
	get_tree().quit()




func _on_SoundSlider_value_changed(value):
	AudioServer.set_bus_volume_db(0, value)


func _on_CheckBox_toggled(button_pressed):
	OS.window_fullscreen = button_pressed


func _on_Back_button_pressed():
	settings_menu.hide()
	start_menu.show()

	tween.interpolate_property(logo, "rect_position", Vector2.UP * 400, logo_pos, 0.75, 
	Tween.TRANS_BOUNCE, Tween.EASE_OUT_IN)
	tween.start()


