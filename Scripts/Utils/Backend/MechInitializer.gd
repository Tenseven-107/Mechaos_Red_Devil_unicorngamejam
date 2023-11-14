extends Node
class_name MechInitializer


# Objects
export var _c_objects: String

export (NodePath) var controller_path: NodePath
onready var controller = get_node(controller_path)

export (NodePath) var entity_path: NodePath
onready var entity: MechEntity = get_node(entity_path)

export (NodePath) var torso_path: NodePath
onready var torso = get_node(torso_path)

export (NodePath) var head_path: NodePath
onready var head = get_node(head_path)

export (NodePath) var arm_left_path: NodePath
onready var arm_left = get_node(arm_left_path)
export (NodePath) var arm_right_path: NodePath
onready var arm_right = get_node(arm_right_path)


# Mech setup
export var _c_mech_setup: String
export (Resource) var setup: Resource = preload("res://Resources/Mechs/Full/Default.tres")

onready var torso_setup: Resource = setup.torso
onready var head_setup: Resource = setup.head
onready var arm_left_setup: Resource = setup.arm_left
onready var arm_right_setup: Resource = setup.arm_right



# Initialize objects 
func _ready():
	initialize_stats()
	initialize_sprites()


func initialize_stats():
	# Set movement
	if controller.has_method("set_new_stats"):
		var speed_stat = (torso_setup.speed + head_setup.speed + 
		arm_left_setup.speed + arm_right_setup.speed)

		var handling_stat = (torso_setup.handling + head_setup.handling + 
		arm_left_setup.handling + arm_right_setup.handling)

		controller.set_new_stats(speed_stat, handling_stat, torso_setup.boost)

	# Set armor and hp
	if controller.has_method("set_new_stats"):
		var hitpoint_stat = (torso_setup.hitpoints + head_setup.hitpoints + 
		arm_left_setup.hitpoints + arm_right_setup.hitpoints)

		var armor_stat = (torso_setup.armor + head_setup.armor + 
		arm_left_setup.armor + arm_right_setup.armor)

		entity.set_new_stats(hitpoint_stat, armor_stat)

	# Set weapons
	if arm_left.has_method("initialize_weapon"):
		arm_left.initialize_weapon(arm_left_setup.weapon)

	if arm_right.has_method("initialize_weapon"):
		arm_right.initialize_weapon(arm_right_setup.weapon)

	var ability_holder = head.get_node("Ability")
	if ability_holder.has_method("initialize_ability"):
		ability_holder.initialize_ability(head_setup.ability)


func initialize_sprites():
	var torso_sprite: Sprite = torso.get_node("Sprite")
	torso_sprite.texture = torso_setup.sprite
	torso_sprite.self_modulate = torso_setup.color

	var head_sprite: Sprite = head.get_node("Sprite")
	head_sprite.texture = head_setup.sprite
	head_sprite.self_modulate = head_setup.color

	var arm_left_sprite: Sprite = arm_left.get_node("Sprite")
	var arm_right_sprite: Sprite = arm_right.get_node("Sprite")

	arm_left_sprite.texture =  arm_left_setup.sprite
	arm_right_sprite.texture = arm_right_setup.sprite

	arm_left_sprite.self_modulate = arm_left_setup.color
	arm_right_sprite.self_modulate = arm_right_setup.color

	arm_right_sprite.flip_v = true



