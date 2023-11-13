extends Node2D


export (String) var weapon_control: String = "attack_right" # Button used for attacking with this arm
var weapon: BulletShooter = null

# Setup
func initialize_weapon(new_weapon: PackedScene):
	var weapon_holder = get_node("Weapon")

	if is_instance_valid(new_weapon):
		var weapon_instance = new_weapon.instance()

		weapon_instance.global_position = weapon_holder.global_position
		weapon_instance.global_rotation = weapon_holder.global_rotation

		weapon = weapon_instance
		weapon.team = 0

		weapon_holder.call_deferred("add_child", weapon_instance)



# Controlling
func _process(delta):
	if is_instance_valid(weapon) and Input.is_action_pressed(weapon_control):
		weapon.play_effect()
