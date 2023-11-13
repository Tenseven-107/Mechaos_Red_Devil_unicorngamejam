tool
extends Node
class_name PostProcessingLayer


# Stats
export (Environment) var enviroment: Environment setget set_enviroment, get_enviroment
export (Array, PackedScene) var shaders setget set_shaders, get_shaders

export (bool) var screenshaders: bool = true setget set_screenshaders, get_screenshaders


# Set/ get world enviroment
func set_enviroment(new_enviroment: Environment):
	var world_environment = get_node("WorldEnvironment")

	enviroment = new_enviroment
	world_environment.environment = enviroment

func get_enviroment():
	return enviroment


# Set/ get shaders
func set_shaders(new_shaders: Array):
	var shader_container: CanvasLayer = get_node("Shaders")

	shaders = new_shaders
	if screenshaders == true:
		for shader in range(shaders.size()):
			var instance = shaders[shader].instance()
			shader_container.add_child(instance)
	else:
		for shader in shader_container.get_children():
			shader.queue_free()

func get_shaders():
	return shaders



# Turn shaders on and off shaders
func set_screenshaders(new_value: bool):
	var shader_container: CanvasLayer = get_node("Shaders")

	screenshaders = new_value
	if screenshaders == true:
		for shader in range(shaders.size()):
			var instance = shaders[shader].instance()
			shader_container.add_child(instance)
	else:
		for shader in shader_container.get_children():
			shader.queue_free()

func get_screenshaders():
	return screenshaders



