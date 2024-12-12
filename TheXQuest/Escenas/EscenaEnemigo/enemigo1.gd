extends Node2D  # O el tipo de nodo que estés usando

var vida: int = 75
var ataque: int = 20
var defensa: int = 5

const VIDA_ENEMIGO = 75
const ATAQUE_ENEMIGO = 20
const DEFENSA_ENEMIGO = 5

@onready var combate = preload("res://Escenas/combate.tscn")

@onready var sprite = $AnimatedSprite2D  # Asegúrate de que el nodo sprite está nombrado correctamente

func _ready():
	vida = VIDA_ENEMIGO
	ataque = ATAQUE_ENEMIGO
	defensa = DEFENSA_ENEMIGO
	

func recibir_daño(cantidad):
	vida -= cantidad
	vida = max(vida, 0)  # No permitir valores negativos
	

func curar(cantidad: int):
	vida += cantidad




func iniciar_juego():
	# Aquí puedes agregar la lógica para comenzar el juego
	print("El juego ha comenzado")  # Reemplaza esto con tu lógica para iniciar el juego
