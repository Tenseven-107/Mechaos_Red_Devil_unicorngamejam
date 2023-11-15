extends Node


# On startup
func _ready():
	create_new_mech()



# Recording time
var total_milliseconds: float = 0
var total_seconds: int = 0
var total_minutes: int = 0
var total_hours: int = 0

func add_total_time(hours: int, minutes: int, seconds: int, milliseconds: float):
	pass



# Saving and building the player mech
var default_arms: MechArm = preload("res://Resources/Mechs/Arms/Naked_Arm.tres")
var default_head: MechHead = preload("res://Resources/Mechs/Heads/Shield_Head.tres")
var default_torso: MechTorso = preload("res://Resources/Mechs/Torsos/Balanced_Torso.tres")

var player_mech: MechSetup

func create_new_mech():
	var new_mech = MechSetup.new()

	new_mech.arm_left = default_arms
	new_mech.arm_right = default_arms

	new_mech.head = default_head
	new_mech.torso = default_torso

	player_mech = new_mech


func change_mech(arm_left: MechArm, arm_right: MechArm, head: MechHead, torso: MechTorso):
	player_mech.arm_left = arm_left
	player_mech.arm_right = arm_right

	player_mech.head = head
	player_mech.torso = torso


func set_new_color(mech_part: Resource, new_color: Color):
	if mech_part.get("color"):
		mech_part.color = new_color


func get_mech():
	if is_instance_valid(player_mech) == false:
		create_new_mech()

	return player_mech


