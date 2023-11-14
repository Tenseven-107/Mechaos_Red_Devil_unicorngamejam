extends Area2D
class_name MechEntity


# Objects
onready var controller = get_parent()

# Variables
var current_hp: int = 25
export (int) var max_hp: int = 25
export (int) var team: int = 0
export (float) var i_frame_time: float = 1
var i_frames: Timer

export (bool) var has_armor = true
export (int) var armor: int = 0
const max_armor: int = 50

# EffectPlayers
export var _c_effect_players: String
export (Array, NodePath) var effects_hit: Array
export (Array, NodePath) var effects_die: Array



# Setup
func _ready():
	setup_timer()
	self.connect("body_entered", self, "check_hit")

func setup_timer():
	var instance: Timer = Timer.new()

	instance.wait_time = i_frame_time
	instance.one_shot = true

	add_child(instance)
	i_frames = instance

func set_new_stats(hp_stat: int, armor_stat: int):
	max_hp = hp_stat
	current_hp = max_hp

	armor = armor_stat
	armor = clamp(armor, 0, max_armor)


# Handle hits
func check_hit(body: Node):
	if body.has_method("hit"):
		body.hit(self)

func handle_hit(damage: int, hit_team: int):
	var armor_calculation = rand_range(0, max_armor)

	if hit_team != team and i_frames.is_stopped() and armor_calculation < armor:
		current_hp -= damage

		controller.decrease_speed(armor)

		# Play effects on hit
		for effect in effects_hit:
			var play_effect: EffectPlayer = get_node(effect)
			play_effect.play_effect()

		if current_hp <= 0:
			die()



# Dying
func die():
	# Play effects on death
	for effect in effects_die:
		var play_effect: EffectPlayer = get_node(effect)
		play_effect.play_effect()

	get_parent().call_deferred("queue_free")





