extends Node


onready var text = $Control/Text
onready var button = $Control/Exit
var main_menu: PackedScene = load("res://Scenes/Menus/MainMenu.tscn")



func _ready():
	var extra_txt: String = ("[color=yellow] Total time: " + TempMemory.get_time_string() 
	+ "[color=white] ,[color=red] Money: " + str(TempMemory.current_money))
	text.bbcode_text +=  extra_txt

	button.connect("pressed", self, "exit")


func exit():
	TempMemory.reset()
	get_tree().change_scene_to(main_menu)
