extends Sprite



export (Array, Texture) var sprites: Array


func _ready():
	randomize()

	var size = sprites.size()
	var number = rand_range(0, size)

	self.texture = sprites[number]
