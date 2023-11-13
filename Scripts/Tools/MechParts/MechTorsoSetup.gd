extends Resource
class_name MechTorso

# Look
export (Texture) var sprite: Texture
export (Color) var color: Color = Color.white

# Weapon
export (float, 12, 100) var boost: float = 12

# Stats
export (float, -300, 300) var speed: float = 200
export (float, -2.5, 2.5) var handling: float = 1.5
export (int, -150, 150) var hitpoints: int = 100
export (int, -35, 35) var armor: int = 20
