extends Node2D


export (NodePath) var bullet_shooter_path: NodePath
onready var bullet_shooter: BulletShooter = get_node(bullet_shooter_path)


export (NodePath) var detection_path: NodePath
onready var detection: Area2D = get_node(detection_path)

var active: bool = false
var target: Node2D = null


func _ready():
	detection.connect("body_entered", self, "check")
	detection.connect("body_exited", self, "uncheck")


func _process(delta):
	if active == true and is_instance_valid(target):
		look_at(target.global_position)
		bullet_shooter.play_effect()


func check(body: Node):
	if body.is_in_group(PlayerController.group):
		active = true
		target = body


func uncheck(body: Node):
	if body.is_in_group(PlayerController.group):
		active = false
		target = null
