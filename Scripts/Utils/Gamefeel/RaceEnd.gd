extends Node



onready var transition = $EndUI/Control/Transition
onready var transition_timer = $TransitionTimer
onready var transition_tween = $Transition_tween

onready var text = $EndUI/Control/Label

var build_scene: PackedScene = load("res://Scenes/Menus/Building.tscn")



func _ready():
	text.hide()

	GlobalSignals.connect("end_race", self, "start_end")
	transition_timer.connect("timeout", self, "start_transition")
	transition_tween.connect("tween_all_completed", self, "load_building")


func start_end():
	transition_timer.start()
	text.show()

func start_transition():
	var material = transition.material
	transition_tween.interpolate_property(material, "shader_param/progress", 0, 1, 1,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	transition_tween.start()

func load_building():
	get_tree().change_scene_to(build_scene)
