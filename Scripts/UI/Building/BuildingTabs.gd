extends Control
class_name BuildingTabs

onready var categories: Array = get_children()


func _ready():
	set_tab(0)


func set_tab(tab: int):
	if tab > categories.size():
		return

	else:
		categories[tab].show()

		var items: Array = categories[tab].get_children()
		for item in items:
			item.check_if_available()

		for category in categories:
			if category != categories[tab]:
				category.hide()

	


