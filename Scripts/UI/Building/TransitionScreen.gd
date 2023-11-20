extends Control


onready var tween = $Tween
onready var timer = $Timer
onready var appear_timer = $AppearTimer

onready var transition_screen = $TransitionScreen
onready var intro_screen = $Intro

onready var label = $Intro/Label
onready var progress = $Intro/TextureProgress

var start_progress: int = 23
var trans_material


func _ready():
	intro_screen.hide()
	progress.value = start_progress

	trans_material = transition_screen.material
	tween.interpolate_property(trans_material, "shader_param/progress", 1, 0, 1,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

	appear_timer.connect("timeout", self, "animation")
	timer.connect("timeout", self, "next_level")


func start_intro():
	appear_timer.start()
	timer.start()

	tween.interpolate_property(trans_material, "shader_param/progress", 0, 1, 1,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func animation():
	label.text = TempMemory.get_next_level_name()
	intro_screen.show()

	tween.interpolate_property(progress, "value", start_progress, progress.max_value, 2.5,
	Tween.TRANS_CIRC, Tween.EASE_IN_OUT)
	tween.start()

func next_level():
	var next = TempMemory.get_next_level()
	get_tree().change_scene_to(next)




