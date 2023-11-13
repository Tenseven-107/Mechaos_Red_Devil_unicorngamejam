extends Area2D
class_name Entity



# Variables
var current_hp: int = 25
export (int) var max_hp: int = 25
export (int) var team: int = 0
export (float) var i_frame_time: float = 1
var i_frames: Timer

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



# Handle hits
func check_hit(body: Node):
	if body.has_method("hit"):
		body.hit(self)
	elif body.has_method("heal"):
		body.heal(self)

func handle_hit(damage: int, hit_team: int):
	if hit_team != team and i_frames.is_stopped():
		current_hp -= damage

		# Play effects on hit
		for effect in effects_hit:
			var play_effect: EffectPlayer = get_node(effect)
			play_effect.play_effect()

		if current_hp <= 0:
			die()

func handle_heal(healed_hp: int, hit_team: int):
	if hit_team == team:
		current_hp += healed_hp
		current_hp = clamp(current_hp, 0, max_hp)



# Dying
func die():
	# Play effects on death
	for effect in effects_die:
		var play_effect: EffectPlayer = get_node(effect)
		play_effect.play_effect()

	get_parent().call_deferred("queue_free")






