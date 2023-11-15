extends Area2D
class_name Checkpoint



var lap_manager = null
var activated: bool = false


func _ready():
	connect("body_entered", self, "detect")



func detect(body: Node):
	if body.is_in_group(PlayerController.group) and activated == false:
		activated = true
		lap_manager.set_progress(self)



func initialize(new_lap_manager):
	lap_manager = new_lap_manager
	activated = false
