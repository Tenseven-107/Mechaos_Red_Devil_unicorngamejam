extends Sprite



export (Array, Texture) var sprites: Array
export (bool) var random_rotation: bool = false


func _ready():
	randomize()

	if sprites.size() > 0:
		var size = sprites.size()
		var number = rand_range(0, size)

		self.texture = sprites[number]

	if random_rotation == true:
		var rand_rot: int = rand_range(0, 360)
		rotation = rand_rot
