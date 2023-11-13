extends KinematicBody2D

export (float) var speed: float = 2
var velocity: Vector2

export (bool) var constant: bool = false
export (float) var pathfinding_update_time: float = 0.1

export (NodePath) var nav_path: NodePath
onready var nav = get_node(nav_path)

export (NodePath) var target_path: NodePath
onready var target = get_node(target_path)

onready var update_timer: Timer = $Timer

onready var agent: NavigationAgent2D = $NavAgent




func _ready():
	agent.set_navigation(nav)

func _physics_process(delta):
	if constant == true or 
		agent.set_target_location(target.global_position)

	if agent.is_navigation_finished() == true:
		return

	var direction = global_position.direction_to(agent.get_next_location())
	
	var new_velocity = direction * 200
	var steering = (new_velocity - velocity) * speed * delta
	velocity += steering
	
	velocity = move_and_slide(velocity)
