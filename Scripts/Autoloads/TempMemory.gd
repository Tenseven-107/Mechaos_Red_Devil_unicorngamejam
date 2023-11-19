extends Node


# On startup
func _ready():
	create_new_mech()

	current_money = default_money
	bought_items_list = default_items_list



# Storing player progress
var level_progress: int = 0
var levels: Array = [
	preload("res://Scenes/Levels/Tokyo-Night.tscn")
]

func update_progress():
	level_progress += 1

func get_next_level():
	return levels[level_progress]


# Recording time
var total_milliseconds: float = 0
var total_seconds: int = 0
var total_minutes: int = 0
var total_hours: int = 0

func add_total_time(minutes: int, seconds: int, milliseconds: float):
	total_milliseconds += milliseconds

	if total_milliseconds >= 1:
		var milliseconds_left = total_milliseconds - milliseconds
		total_milliseconds = milliseconds_left

		total_seconds += 1
		total_seconds += seconds

		if total_seconds >= 60:
			var seconds_left = total_seconds - seconds
			total_seconds = seconds_left

			total_minutes += 1
			total_minutes += minutes

			if total_minutes >= 60:
				var minutes_left = total_minutes - minutes
				total_minutes = minutes_left

				total_hours += 1



# Storing money
const default_money: int = 20000
var current_money: int = 0

func add_money(new_money: int):
	current_money += new_money

func remove_money(removed_money: int):
	current_money -= removed_money


func can_remove_money(money: int):
	if current_money - money >= 0:
		return true

	else: return false



# Saving and building the player mech
const default_arms: MechArm = preload("res://Resources/Mechs/Arms/Naked_Arm.tres")
const default_head: MechHead = preload("res://Resources/Mechs/Heads/Naked_Head.tres")
const default_torso: MechTorso = preload("res://Resources/Mechs/Torsos/Balanced_Torso.tres")

var player_mech: MechSetup

func create_new_mech():
	var new_mech = MechSetup.new()

	new_mech.arm_left = default_arms
	new_mech.arm_right = default_arms

	new_mech.head = default_head
	new_mech.torso = default_torso

	player_mech = new_mech

func equip_head(part: MechHead):
	player_mech.head = part
func equip_torso(part: MechTorso):
	player_mech.torso = part
func equip_arm_left(part: MechArm):
	player_mech.arm_left = part
func equip_arm_right(part: MechArm):
	player_mech.arm_right = part

func set_new_color(mech_part: Resource, new_color: Color):
	if mech_part.get("color"):
		mech_part.color = new_color


func get_mech():
	if is_instance_valid(player_mech) == false:
		create_new_mech()

	return player_mech



# Bought items
const default_items_list: Array = [
	"naked_head",
	"balanced_torso",
	"arm_naked",
	"arm_fist",
	"emp_head"
]

var bought_items_list: Array = []


func add_item(item_id: String):
	bought_items_list.append(item_id)

func check_if_bought(item_id: String):
	for item in bought_items_list:
		if item_id == item:
			return true

	return false


