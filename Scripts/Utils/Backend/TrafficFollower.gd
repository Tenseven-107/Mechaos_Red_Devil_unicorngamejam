extends PathFollow2D
class_name TrafficFollower


export (int) var max_speed: int = 45
export (int) var min_speed: int = 5
var speed: int = 0


func _ready():
	randomize()
	var random_speed: int = rand_range(min_speed, max_speed)
	speed = random_speed


func _physics_process(delta):
	offset += speed * delta
