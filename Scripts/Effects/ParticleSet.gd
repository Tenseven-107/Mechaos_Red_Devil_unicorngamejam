extends Node2D


onready var timer = $Timer

export (NodePath) var sfx_path: NodePath
export (Array, NodePath) var particle_paths: Array
onready var particles: Array = get_particles()

export (float) var stay_time: float = 1


func get_particles():
	var particle_array: Array
	for path in particle_paths:
		var particle = get_node(path)
		particle_array.append(particle)

	return particle_array


func _ready():
	if sfx_path != null:
		var sfx = get_node(sfx_path)
		sfx.play()

	timer.wait_time = stay_time
	timer.start()

	for particle in particles:
		particle.emitting = true

	timer.connect("timeout", self, "queue_free")
