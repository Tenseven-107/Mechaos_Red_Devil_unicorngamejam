extends EffectPlayer



onready var sprite = $Sprite
onready var tween = $Tween
onready var collider = $Shield_collider/Collider

onready var shield_timer = $Shield_time
onready var cooldown = $Shield_cooldown



func _ready():
	collider.disabled = true
	sprite.hide()

	shield_timer.connect("timeout", self, "disable")


func play_effect():
	if shield_timer.is_stopped() and cooldown.is_stopped():
		collider.disabled = false
		sprite.show()

		tween.interpolate_property(sprite, "scale", Vector2.ZERO, Vector2.ONE, 0.2, 
		Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
		tween.interpolate_property(sprite, "modulate", Color.aqua, Color.white, 0.3, 
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()

		shield_timer.start()
		cooldown.start()


func disable():
	collider.disabled = true
	sprite.hide()
