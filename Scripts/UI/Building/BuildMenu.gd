extends CanvasLayer
class_name BuildingMenu


onready var transition = $Control/Transition

onready var money_label = $Control/MenuItems/Money
onready var next_scene_button = $"Control/MenuItems/Roll-out"

onready var speed_bar = $Control/Stats/Containers/Bars/Speed
onready var handling_bar = $Control/Stats/Containers/Bars/Handling
onready var hp_bar = $Control/Stats/Containers/Bars/HP
onready var armor_bar = $Control/Stats/Containers/Bars/Armor
onready var boost_bar = $Control/Stats/Containers/Bars/Boost

export (float) var max_speed: float = 650
export (float) var max_handling: float = 5.5
export (int) var max_hp: int = 275
export (int) var max_armor: int = 50
export (float) var max_boost: float = 100

var selected_part: Resource = null


func _ready():
	Engine.time_scale = 1

	set_bars()
	update_bars()
	update_ui()

	next_scene_button.connect("pressed", transition, "start_intro")

func update_ui():
	money_label.bbcode_enabled = true
	var text_code: String = "[center][rainbow][wave]$ " + str(TempMemory.current_money)

	money_label.bbcode_text = text_code



func update_bars():
	var mech: MechSetup = TempMemory.get_mech()
	var speed = (mech.head.speed + mech.torso.speed + mech.arm_left.speed + mech.arm_right.speed)
	var handling = (mech.head.handling + mech.torso.handling + mech.arm_left.handling + mech.arm_right.handling)
	var hp = (mech.head.hitpoints + mech.torso.hitpoints + mech.arm_left.hitpoints + mech.arm_right.hitpoints)
	var armor = (mech.head.armor + mech.torso.armor + mech.arm_left.armor + mech.arm_right.armor)
	var boost = mech.torso.boost

	speed_bar.value = speed
	handling_bar.value = handling
	hp_bar.value = hp
	armor_bar.value = armor
	boost_bar.value = boost


func set_bars():
	speed_bar.max_value = max_speed
	handling_bar.max_value = max_handling
	hp_bar.max_value = max_hp
	armor_bar.max_value = max_armor
	boost_bar.max_value = max_boost



func select_part(part: Resource):
	selected_part = part


func _on_ColorPicker_color_changed(color: Color):
	if color == Color.black:
		color = Color.white

	if is_instance_valid(selected_part) and selected_part.get("color"):
		TempMemory.set_new_color(selected_part, color)
