extends KinematicBody2D
class_name PlayerController


export (NodePath) var boost_bar_path: NodePath
onready var boost_bar: TextureProgress

# Stats
# - Movement
const minimum_speed: int = 5
var current_speed: float = 0
export (float) var max_speed: float = 250
export (float) var acceleration: float = 50
const decceleration: float = 2.5
export (float) var handling: float = 1.5

var velocity: Vector2 = Vector2.ZERO
var move_input: float

# - Boost
const boost: int = 5
var can_boost: bool = true
var current_boost_time: float = 0
export (float) var boost_time: float = 25

# Misc
const group: String = "Racer"
var active: bool = false



# Setup
func _ready():
	add_to_group(group)
	GlobalSignals.connect("start_race", self, "start")

func start(): active = true



# processes
func _physics_process(delta):
	movement(delta)
	boosting(delta)



# Movement
func movement(delta):
	if Input.is_action_pressed("left"):
		rotation -= handling * delta
	if Input.is_action_pressed("right"):
		rotation += handling * delta

	var temp_move_input: float = Input.get_axis("deccelerate", "accelerate")

	if temp_move_input != 0:
		if current_speed < max_speed:
			current_speed += acceleration * delta

		move_input = temp_move_input

	if ((current_speed > 0 and current_speed <= max_speed and temp_move_input == 0)
	or current_speed > max_speed):
		current_speed -= decceleration

	if current_speed > minimum_speed and active == true: 
		velocity = Vector2(move_input * current_speed, 0).rotated(rotation)
	velocity = move_and_slide(velocity) * delta



# Boosting
func boosting(delta):
	if Input.is_action_pressed("boost") and current_boost_time > 0 and can_boost == true:
		current_speed += boost
		current_boost_time -= 0.1

		if current_boost_time <= 0:
			can_boost = false

			boost_bar.modulate = Color.red

		boost_bar.value = current_boost_time

	if ((can_boost == false or current_boost_time < boost_time) 
	and Input.is_action_pressed("boost") == false):
		current_boost_time += 0.075

		if current_boost_time >= boost_time:
			current_boost_time = boost_time
			can_boost = true

			boost_bar.modulate = Color.white

		boost_bar.value = current_boost_time




# Decrease speed
func decrease_speed(armor: int):
	current_speed /= armor



# Set new stats
func set_new_stats(speed_stat: float, handling_stat: float, boost_stat: float):
	max_speed = speed_stat

	var new_acceleration = speed_stat / 5
	acceleration = new_acceleration

	handling = handling_stat
	boost_time = boost_stat
	current_boost_time = boost_time

	boost_bar = get_node(boost_bar_path)
	boost_bar.max_value = boost_time
	boost_bar.value = current_boost_time









