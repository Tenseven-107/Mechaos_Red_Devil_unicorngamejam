extends EffectPlayer
class_name BulletShooter



# Stats
export var _c_Stats: String
# - Misc
export var _c_Misc: String
export (int) var team: int = 0

# - Projectiles
export var _c_Projectiles: String
export (PackedScene) var projectile: PackedScene
export (bool) var circle: bool = false
export (int) var bullets: int = 1

# - Fire stats
export var _c_Firing: String
export (float) var firerate_cooldown: float = 0.1
var plus_rotation: float = 0

onready var firerate_timer: Timer

# - Objects
export (NodePath) var muzzle_path: NodePath
onready var muzzle = get_node(muzzle_path)
var bullet_container = null

# Juice
export var _c_effect_players: String
export (Array, NodePath) var effects_on_fire: Array



# Set up
func _ready():
	setup_timer()

func setup_timer():
	# Dash timer
	var firerate_instance: Timer = Timer.new()

	firerate_instance.wait_time = firerate_cooldown
	firerate_instance.one_shot = true

	add_child(firerate_instance)
	firerate_timer = firerate_instance



# Fire bullets
func play_effect():
	if is_instance_valid(bullet_container) == false:
		get_bullet_container()

	if firerate_timer.is_stopped():
		firerate_timer.start()

		for bullet in range(bullets):
			var bullet_instance: Bullet = projectile.instance()

			bullet_instance.global_position = muzzle.global_position
			bullet_instance.global_rotation = muzzle.global_rotation + plus_rotation
			bullet_instance.team = team

			if circle == true:
				plus_rotation += 360 / bullets
				if plus_rotation >= 360:
					plus_rotation = 0

			bullet_container.call_deferred("add_child", bullet_instance)



# Initialization
func get_bullet_container():
	var containers = get_tree().get_nodes_in_group(BulletContainer.group_name)
	bullet_container = containers[0]







