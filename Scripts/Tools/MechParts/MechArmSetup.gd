extends Resource
class_name MechArm

# Look
export (Texture) var sprite: Texture
export (Color) var color: Color = Color.white

# Weapon
export (PackedScene) var weapon: PackedScene

# Stats
export (float, -150, 150) var speed: float = 25
export (float, -1, 1) var handling: float = 0.25
export (int, -50, 50) var hitpoints: int = 25
export (int, -5, 5) var armor: int = 2
