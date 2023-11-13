extends TileMap


export (bool) var debug: bool = false setget set_debug, get_debug



func _ready():
	visible = debug



func set_debug(value: bool):
	debug = value
	visible = debug

func get_debug():
	return debug


