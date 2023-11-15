extends Node2D


export (NodePath) var path_path: NodePath
onready var path: Path2D = get_node(path_path)

export (PackedScene) var traffic_vehicle: PackedScene

export (int) var min_traffic: int = 100
export (int) var max_traffic: int = 150


func _ready():
	generate()

	GlobalSignals.connect("finish_crossed", self, "generate")


func generate():
	if path.get_child_count() > 0:
		var path_children = path.get_children()
		for child in path_children:
			child.call_deferred("queue_free")

	var traffic_number: int = rand_range(min_traffic, max_traffic)
	for traffic in range(traffic_number):
		var instance = traffic_vehicle.instance()
		path.call_deferred("add_child", instance)

		var path_position = rand_range(0, path.curve.get_baked_length())
		instance.offset = path_position
