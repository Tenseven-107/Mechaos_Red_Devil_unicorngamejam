extends Resource
class_name MechHead

# Look
export (Texture) var sprite: Texture
export (Color) var color: Color = Color.white

# Weapon
export (PackedScene) var ability: PackedScene

# Stats
export (float, -50, 50) var speed: float = 10
export (float, -1, 1) var handling: float = 0.1
export (int, -25, 25) var hitpoints: int = 5
export (int, -5, 5) var armor: int = 0
