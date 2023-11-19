extends Button


export (NodePath) var tabs_container_path: NodePath
onready var tabs_container: BuildingTabs = get_node(tabs_container_path)

export (int) var tab_to_show: int =0


func _pressed():
	tabs_container.set_tab(tab_to_show)
