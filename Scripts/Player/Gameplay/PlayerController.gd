extends KinematicBody2D


# Stats
# - Movement
const minimum_speed: int = 5
var current_speed: float = 0
export (float) var max_speed: float = 250
export (float) var acceleration: float = 50
export (float) var decceleration: float = 25
export (float) var handling: float = 1.5

var velocity: Vector2 = Vector2.ZERO
var move_input: float

# - Boost
const boost: int = 5
var can_boost: bool = true
var current_boost_time: float = 0
export (float) var boost_time: float = 25



# Setup
func _ready():
	current_boost_time = boost_time



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

	if current_speed > minimum_speed: velocity = Vector2(move_input * current_speed, 0).rotated(rotation)
	velocity = move_and_slide(velocity) * delta



# Boosting
func boosting(delta):
	if Input.is_action_pressed("boost") and current_boost_time > 0 and can_boost == true:
		current_speed += boost
		current_boost_time -= 0.1

		if current_boost_time <= 0:
			can_boost = false

	if ((can_boost == false or current_boost_time < boost_time) 
	and Input.is_action_pressed("boost") == false):
		current_boost_time += 0.075

		if current_boost_time >= boost_time:
			current_boost_time = boost_time
			can_boost = true



# Decrease speed
func decrease_speed(armor: int):
	current_speed /= armor



# Set new stats
func set_new_stats(speed_stat: float, handling_stat: float, boost_stat: float):
	max_speed = speed_stat

	var new_acceleration = speed_stat / 5
	var new_decceleration = speed_stat / 100
	acceleration = new_acceleration
	decceleration = new_decceleration

	handling = handling_stat

	boost_time = boost_stat









