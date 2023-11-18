extends Node2D


export (NodePath) var bullet_shooter_path: NodePath
onready var bullet_shooter: BulletShooter = get_node(bullet_shooter_path)

export (NodePath) var detection_path: NodePath
onready var detection: Area2D = get_node(detection_path)


func _ready():
	detection.connect("body_entered", self, "check")


func check(body: Node):
	if body.is_in_group(PlayerController.group):
		bullet_shooter.play_effect()
		call_deferred("queue_free")
