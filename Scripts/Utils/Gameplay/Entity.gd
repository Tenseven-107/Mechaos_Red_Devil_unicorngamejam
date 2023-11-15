extends Area2D
class_name Entity



# Variables
var current_hp: int = 25
export (int) var max_hp: int = 25
export (int) var team: int = 0

# EffectPlayers
export var _c_effect_players: String
export (Array, NodePath) var effects_hit: Array
export (Array, NodePath) var effects_die: Array



# Setup
func _ready():
	self.connect("body_entered", self, "check_hit")



# Handle hits
func check_hit(body: Node):
	if body.has_method("hit"):
		body.hit(self)

func handle_hit(damage: int, hit_team: int):
	if hit_team != team:
		current_hp -= damage

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






