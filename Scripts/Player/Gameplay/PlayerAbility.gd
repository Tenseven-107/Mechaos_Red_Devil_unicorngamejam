extends Node


var ability = null


# Setup
func initialize_ability(new_ability: PackedScene):
	if is_instance_valid(new_ability):
		var ability_instance = new_ability.instance()

		ability = ability_instance
		if ability.get("team"):
			ability.team = 0

		self.call_deferred("add_child", ability_instance)



# Controlling
func _process(delta):
	if is_instance_valid(ability) and Input.is_action_pressed("ability"):
		ability.play_effect()
