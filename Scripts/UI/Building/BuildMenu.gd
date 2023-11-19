extends CanvasLayer
class_name BuildingMenu


onready var money_label = $Control/Money

var selected_part: Resource = null


func _ready():
	update_ui()

func update_ui():
	money_label.bbcode_enabled = true
	var text_code: String = "[center][rainbow][wave]$ " + str(TempMemory.current_money)

	money_label.bbcode_text = text_code



func select_part(part: Resource):
	selected_part = part


func _on_ColorPicker_color_changed(color: Color):
	if is_instance_valid(selected_part) and selected_part.get("color"):
		TempMemory.set_new_color(selected_part, color)
