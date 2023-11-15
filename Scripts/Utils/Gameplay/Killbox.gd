extends Area2D
class_name Killbox


export (int) var damage: int = 1000
export (int) var team: int = 0


func _ready():
	self.connect("area_entered", self, "try_hit")

func try_hit(body: Node):
	if body.has_method("handle_hit"):
		body.handle_hit(damage, team)
