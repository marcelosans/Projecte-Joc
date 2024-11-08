extends Node2D

# Variables exportadas para ajustar velocidad y duración desde el inspector
export var speed: float = 200.0 # Velocidad en píxeles por segundo
export var duration: float = 3.0 # Duración del movimiento en segundos
var rotation_speed = 12.0
var elapsed_time: float = 0.0
onready var Luces = $Luces

func _ready():
	# Esto hace visible a Luces cuando comienza el juego
	Luces.visible = true

func _process(delta):
	# Aumentar el tiempo transcurrido
	elapsed_time += delta
	rotation += rotation_speed * delta
	# Mover el nodo hacia la derecha si no ha terminado la duración
	if elapsed_time < duration:
		position.x += speed * delta
