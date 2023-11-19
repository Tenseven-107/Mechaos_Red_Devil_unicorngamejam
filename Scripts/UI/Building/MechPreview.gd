extends Node2D


onready var body = $Body
onready var arm_left = $Arm_left
onready var arm_right = $Arm_right
onready var head = $Head

var mech_setup: MechSetup = null


func _ready():
	mech_setup = TempMemory.get_mech()


func _process(delta):
	var mech_torso: MechTorso = mech_setup.torso
	body.texture = mech_torso.sprite
	body.modulate = mech_torso.color

	var mech_arm_left: MechArm = mech_setup.arm_left
	arm_left.texture = mech_arm_left.sprite
	arm_left.modulate = mech_arm_left.color

	var mech_arm_right: MechArm = mech_setup.arm_right
	arm_right.texture = mech_arm_right.sprite
	arm_right.modulate = mech_arm_right.color

	var mech_head: MechHead = mech_setup.head
	head.texture = mech_head.sprite
	head.modulate = mech_head.color


