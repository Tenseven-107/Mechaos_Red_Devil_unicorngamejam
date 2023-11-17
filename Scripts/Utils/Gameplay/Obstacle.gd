extends Node2D


onready var obstacle_holder = $ObstacleHolder

export (PackedScene) var obstacle_object: PackedScene
export (bool) var can_respawn: bool = true



func _ready():
	spawn()

	if can_respawn == true:
		GlobalSignals.connect("finish_crossed", self, "spawn")


func spawn():
	if obstacle_holder.get_child_count() == 0:
		var instance = obstacle_object.instance()
		obstacle_holder.call_deferred("add_child", instance)
