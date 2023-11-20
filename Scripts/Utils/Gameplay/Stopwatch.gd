extends Node


onready var current_label = $TimerUI/Control/Current
onready var last_label = $TimerUI/Control/Last


var last_milliseconds: float = 0
var last_seconds: int = 0
var last_minutes: int = 0

var current_milliseconds: float = 0
var current_seconds: int = 0
var current_minutes: int = 0

var total_milliseconds: float = 0
var total_seconds: int = 0
var total_minutes: int = 0

var active: bool = false


func _ready():
	GlobalSignals.connect("start_race", self, "start")
	GlobalSignals.connect("end_race", self, "finish")
	GlobalSignals.connect("finish_crossed", self, "reset")



func _process(delta):
	if active == true:
		record(delta)


func record(delta):
	current_milliseconds += delta
	total_milliseconds += delta

	if current_milliseconds >= 1:
		current_milliseconds = 0
		current_seconds += 1

		if current_seconds >= 60:
			current_seconds = 0
			current_minutes += 1

	var time_text: String = "%02d:%02d.%02d" % [current_minutes, current_seconds, int(current_milliseconds * 100)]
	current_label.text = time_text

	if total_milliseconds >= 1:
		total_milliseconds = 0
		total_seconds += 1

		if total_seconds >= 60:
			total_seconds = 0
			total_minutes += 1


func reset():
	last_milliseconds = current_milliseconds
	last_seconds = current_seconds
	last_minutes = current_minutes

	var last_time_text: String = "%02d:%02d.%02d" % [last_minutes, last_seconds, int(last_milliseconds * 100)]
	last_label.text = last_time_text

	current_milliseconds = 0
	current_seconds = 0
	current_minutes = 0


func finish():
	TempMemory.add_total_time(total_minutes, total_seconds, total_milliseconds)
	active = false

func start():
	active = true


