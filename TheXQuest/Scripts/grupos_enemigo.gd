extends Node2D

var enemies: Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	enemies = get_children()
	for i in range(enemies.size()):
		enemies[i].position = Vector2(i * 256, 0)  # Posiciona horizontalmente
