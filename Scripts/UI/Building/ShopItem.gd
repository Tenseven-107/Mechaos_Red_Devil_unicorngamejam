extends Button
class_name ShopItem


export (NodePath) var menu_path: NodePath
onready var menu: BuildingMenu = get_node(menu_path)

export (NodePath) var popup_path: NodePath
onready var popup: ConfirmationDialog = get_node(popup_path)

export (Resource) var part_resource: Resource

enum ITEMTYPE {
	HEAD,
	TORSO,
	LEFT_ARM,
	RIGHT_ARM
}
export (ITEMTYPE) var item_type: int = 0

export (int) var price: int = 0
export (String) var item_id: String
var bought: bool = false


func _ready():
	icon = part_resource.sprite

	check_if_available()


func _pressed():
	if bought == true:
		var mech: MechSetup = TempMemory.get_mech()

		match item_type:
			ITEMTYPE.HEAD:
				TempMemory.equip_head(part_resource)
				menu.select_part(mech.head)
			ITEMTYPE.TORSO:
				TempMemory.equip_torso(part_resource)
				menu.select_part(mech.torso)
			ITEMTYPE.LEFT_ARM:
				TempMemory.equip_arm_left(part_resource)
				menu.select_part(mech.arm_left)
			ITEMTYPE.RIGHT_ARM:
				TempMemory.equip_arm_right(part_resource)
				menu.select_part(mech.arm_right)

	elif TempMemory.can_remove_money(price):
		popup.popup()

		var popup_text: String = "Buy for $ " + str(price)
		popup.dialog_text = popup_text

		if popup.is_connected("confirmed", self, "buy") == false:
			popup.connect("confirmed", self, "buy")


func check_if_available():
	modulate = Color.red

	if TempMemory.check_if_bought(item_id) == true:
		bought = true
		modulate = Color.white



func buy():
	bought = true
	modulate = Color.white

	TempMemory.remove_money(price)
	TempMemory.add_item(item_id)

	menu.update_ui()

	popup.disconnect("confirmed", self, "buy")




