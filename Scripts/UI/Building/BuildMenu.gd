extends CanvasLayer
class_name BuildingMenu


onready var money_label = $Control/MenuItems/Money
onready var next_scene_button = $"Control/MenuItems/Roll-out"

var selected_part: Resource = null


func _ready():
	update_ui()

	next_scene_button.connect("pressed", self, "next_scene")

func update_ui():
	money_label.bbcode_enabled = true
	var text_code: String = "[center][rainbow][wave]$ " + str(TempMemory.current_money)

	money_label.bbcode_text = text_code



func select_part(part: Resource):
	selected_part = part


func _on_ColorPicker_color_changed(color: Color):
	if color == Color.black:
		color = Color.white

	if is_instance_valid(selected_part) and selected_part.get("color"):
		TempMemory.set_new_color(selected_part, color)



func next_scene():
	get_tree().change_scene_to(TempMemory.get_next_level())
