extends Node


onready var ui = $StartUI

onready var label = $StartUI/Control/Label
onready var transition = $StartUI/Control/Transition

onready var timer_tween  =$Timer_tween
onready var transition_tween = $Transition_tween

onready var timer: Timer = $Timer
onready var go_time: Timer = $Go_time

export (int) var time: int = 3
var current_time: int = 3


func _ready():
	current_time = time
	label.text = str(current_time)

	var material = transition.material
	transition_tween.interpolate_property(material, "shader_param/progress", 1, 0, 1,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	transition_tween.start()

	timer.start()
	go_time.connect("timeout", ui, "hide")



func _on_Timer_timeout():
	current_time -= 1
	label.text = str(current_time)

	timer_tween.interpolate_property(label, "rect_scale", Vector2.ZERO, Vector2.ONE, 0.25,
	Tween.TRANS_ELASTIC, Tween.EASE_IN_OUT)
	timer_tween.start()

	if current_time > 0:
		timer.start()
	else:
		GlobalSignals.emit_signal("start_race")

		label.text = "GO!"
		go_time.start()

