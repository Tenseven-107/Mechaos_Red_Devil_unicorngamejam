extends Node



onready var tween = $Tween
onready var game_over_ui = $"GameOver-UI"

var main_menu: PackedScene = load("res://Scenes/Menus/MainMenu.tscn")
var pitch: AudioEffectPitchShift


func _ready():
	game_over_ui.hide()

	GlobalSignals.connect("dead", self, "game_over")



func game_over():
	game_over_ui.show()

	AudioServer.set_bus_effect_enabled(0,0, true)
	pitch = AudioServer.get_bus_effect(0, 0)
	tween.interpolate_property(pitch, "pitch_scale", 1.0, 0.1, 2, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.start()



func _on_Retry_button_pressed():
	AudioServer.set_bus_effect_enabled(0,0, false)

	get_tree().reload_current_scene()


func _on_Quit_button_pressed():
	AudioServer.set_bus_effect_enabled(0,0, false)

	get_tree().change_scene_to(main_menu)





