extends Camera2D
class_name GameCamera


onready var shake_timer = $CamShake/Shake_timer
onready var shake_tween = $CamShake/Shake_tween
onready var zoom_tween = $Zoom/Zoom_tween
onready var zoom_timer = $Zoom/Zoom_timer
onready var hitstop_tween = $Hitstop/Hitstop_tween
onready var hitstop_timer = $Hitstop/Hitstop_timer

export (bool) var snappy_camera: bool = false

var player_target: Node = null

var shake_amount: float = 0
var normal_offset = offset
var zoom_amount: float = 0
var normal_zoom = zoom

var shaking: bool = false

export (NodePath) var target_path: NodePath
onready var target = get_node(target_path)


# Set up
func _ready():
	shaking = false
	set_as_toplevel(true)

	GlobalSignals.connect("camera_shake", self, "shake")
	GlobalSignals.connect("camera_zoom", self, "zoom_cam")
	GlobalSignals.connect("hitstop", self, "time_stop")
	GlobalSignals.connect("set_camera", self, "set_target")


func set_target(new_target: Node2D):
	target = new_target



# Process
func _process(delta):
	var fps = Engine.get_frames_per_second()
	if fps <= 30:
		smoothing_enabled = false
	else:
		smoothing_enabled = true

	if snappy_camera:
		var x = global_position.x
		var y = global_position.y
		global_position = Vector2(int(x), int(y))

		var offset_x = offset.x
		var offset_y = offset.y
		offset = Vector2(int(offset_x), int(offset_y))

	if shaking:
		offset = normal_offset - Vector2(rand_range(-shake_amount, shake_amount),
		rand_range(shake_amount, -shake_amount)) * delta

func _physics_process(delta):
	if is_instance_valid(target):
		global_position = target.global_position


# Camera shake
func shake(new_shake, shake_time, shake_limit):
	var fps = Engine.get_frames_per_second()
	if fps <= 60:
		new_shake /= 2
		shake_limit /= 2

	shaking = true
	shake_amount += new_shake
	if shake_amount > shake_limit:
		shake_amount = shake_limit

	shake_timer.wait_time = shake_time
	shake_tween.stop_all()
	shake_timer.start()


func _on_Shake_timer_timeout():
	shake_amount = 0
	shaking = false

	shake_tween.interpolate_property(self, "offset", offset, normal_offset, 0.1, 
	Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	shake_tween.start()



# Camera zoom
func zoom_cam(new_zoom, zoom_time, zoom_limit):
	zoom_amount -= new_zoom
	zoom_amount = clamp(zoom_amount, zoom_limit, 1)

	zoom = Vector2(zoom_amount, zoom_amount)

	zoom_timer.wait_time = zoom_time
	zoom_tween.stop_all()
	zoom_timer.start()


func _on_Zoom_timer_timeout():
	shake_tween.interpolate_property(self, "zoom", zoom, normal_zoom, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	shake_tween.start()



# Hitstop
func time_stop(time):
	hitstop_tween.interpolate_property(Engine, "time_scale", 0.01, 1, time, Tween.TRANS_LINEAR)

	hitstop_timer.wait_time = time
	hitstop_timer.start()
	hitstop_tween.start()



func _on_Hitstop_timer_timeout():
	Engine.time_scale = 1



func initialize(player: Node):
	player_target = player






