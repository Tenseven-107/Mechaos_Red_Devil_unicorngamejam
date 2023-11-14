extends Line2D


export (int) var trail_length: int = 5
export (bool) var trail_active: bool = true


func _physics_process(delta):
	generate_trail()


# Generating Trail
func generate_trail():
	if trail_active == true:
		global_position = Vector2.ZERO
		global_rotation = 0

		var point: Vector2 = get_parent().global_position
		self.add_point(point)

		while self.get_point_count() > trail_length:
			self.remove_point(0)
