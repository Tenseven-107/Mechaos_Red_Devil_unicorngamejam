extends Node
class_name MoneyManager


onready var container = $MoneyPopupContainer

onready var text = $MoneyUI/Control/Text
onready var tween = $Tween


export (PackedScene) var money_effect: PackedScene
var current_money: int = 0

const group: String = "MoneyManager"
const text_code: String = "[center][wave][rainbow]$ "



func _ready():
	current_money = TempMemory.current_money
	GlobalSignals.connect("end_race", self, "deposit")

	add_to_group(group)

	text.bbcode_enabled = true
	text.bbcode_text = text_code + str(current_money)



func add_money(money: int, position: Vector2):
	current_money += money

	text.bbcode_text = text_code + str(current_money)

	tween.interpolate_property(text, "rect_scale", Vector2.ZERO, Vector2.ONE, 0.15, 
	Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
	tween.start()

	# Spawning money popup
	var instance: MoneyPopup = money_effect.instance()

	instance.global_position = position
	instance.amount = money

	container.call_deferred("add_child", instance)



func deposit():
	var total_earned = current_money - TempMemory.current_money
	TempMemory.add_money(total_earned)
