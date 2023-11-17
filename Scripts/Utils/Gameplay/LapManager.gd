extends Node
class_name LapManager


onready var laps_label = $LapUI/Control/Laps
onready var lap_fade = $LapUI/Control/Lap_fade
onready var lap_tween = $Lap_tween

export (Array, NodePath) var checkpoints: Array
var next_checkpoint_index = 0

var current_lap: int = 0
export (int) var total_laps: int = 4



func _ready():
	for checkpoint_object in checkpoints:
		var checkpoint = get_node(checkpoint_object)
		checkpoint.initialize(self)

	var laps_text: String = str(current_lap) + "/" + str(total_laps)
	laps_label.text = laps_text


func set_progress(current_checkpoint: Checkpoint):
	if current_checkpoint == get_node(checkpoints[next_checkpoint_index]):
		next_checkpoint_index += 1

		if next_checkpoint_index >= checkpoints.size() and check_if_can_finish() == true:
			next_checkpoint_index = 0
			finish()



func finish():
	GlobalSignals.emit_signal("finish_crossed")

	for checkpoint_object in checkpoints:
		var checkpoint = get_node(checkpoint_object)
		checkpoint.activated = false

	current_lap += 1
	var laps_text: String = str(current_lap) + "/" + str(total_laps)
	laps_label.text = laps_text

	lap_tween.interpolate_property(laps_label, "rect_scale", Vector2.ONE * 2, Vector2.ONE, 1.5,
	Tween.TRANS_ELASTIC, Tween.EASE_IN_OUT)
	lap_tween.interpolate_property(lap_fade, "color", Color.silver, Color(0,0,0,0), 1, 
	Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
	lap_tween.start()

	if current_lap > total_laps:
		GlobalSignals.emit_signal("end_race")



func check_if_can_finish():
	for checkpoint_object in checkpoints:
		var checkpoint = get_node(checkpoint_object)
		if checkpoint.activated == false:
			return false

	return true
