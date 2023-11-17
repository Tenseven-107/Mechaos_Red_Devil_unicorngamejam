extends Node2D
class_name MoneyPopup


onready var text = $UI/Text
onready var ui = $UI

onready var timer = $Timer
onready var tween = $Tween

export (float) var stay_time: float = 0.2
var amount: int = 0
const code: String = "[center][wave][rainbow]$ "


func _ready():
	text.bbcode_enabled = true

	timer.wait_time = stay_time
	if amount >= 100:
		var amount_time_modifier = amount / 100
		timer.wait_time = stay_time * amount_time_modifier

	timer.start()

	text.bbcode_text = code + str(amount)

	timer.connect("timeout", self, "dissapear")
	tween.connect("tween_all_completed", self, "queue_free")


func dissapear():
	tween.interpolate_property(ui, "scale", Vector2.ONE, Vector2.ZERO, 0.2, 
	Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)

	tween.start()
